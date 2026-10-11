#!/bin/zsh

# Local web server for macOS using only the zsh modules included with the OS.
# No Node.js, npm, Python or VS Code extension is required.

setopt NO_NOMATCH

ROOT_DIR="${0:A:h}"
PORT=5500
LAST_PORT=5510

if ! zmodload zsh/net/tcp 2>/dev/null; then
  print -u2 "Unable to load the macOS zsh networking module."
  print -u2 "Open index.html directly as a fallback."
  exit 1
fi

LISTENER=""
while (( PORT <= LAST_PORT )); do
  if ztcp -l "$PORT" 2>/dev/null; then
    LISTENER="$REPLY"
    break
  fi
  (( PORT++ ))
done

if [[ -z "$LISTENER" ]]; then
  print -u2 "Ports 5500-5510 are already in use. Close the earlier website task and try again."
  exit 1
fi

cleanup() {
  [[ -n "$LISTENER" ]] && ztcp -c "$LISTENER" 2>/dev/null
}
trap cleanup EXIT INT TERM

mime_type() {
  case "$1" in
    *.html) print -r -- "text/html; charset=utf-8" ;;
    *.css)  print -r -- "text/css; charset=utf-8" ;;
    *.js)   print -r -- "text/javascript; charset=utf-8" ;;
    *.json) print -r -- "application/json; charset=utf-8" ;;
    *.txt)  print -r -- "text/plain; charset=utf-8" ;;
    *.svg)  print -r -- "image/svg+xml" ;;
    *.png)  print -r -- "image/png" ;;
    *.jpg|*.jpeg) print -r -- "image/jpeg" ;;
    *) print -r -- "application/octet-stream" ;;
  esac
}

send_text() {
  local client="$1"
  local http_status="$2"
  local body="$3"
  local length
  length="$(printf '%s' "$body" | wc -c | tr -d ' ')"
  printf 'HTTP/1.1 %s\r\n' "$http_status" >&$client
  printf 'Content-Type: text/plain; charset=utf-8\r\n' >&$client
  printf 'Content-Length: %s\r\n' "$length" >&$client
  printf 'Cache-Control: no-store\r\nConnection: close\r\n\r\n' >&$client
  printf '%s' "$body" >&$client
}

URL="http://localhost:${PORT}/"
print "Online GP website is running at ${URL}"
print "Keep this terminal open. Press Control+C to stop the website."

if [[ -z "${NO_BROWSER:-}" ]]; then
  command open "$URL" >/dev/null 2>&1 &!
fi

while true; do
  if ! ztcp -a "$LISTENER" 2>/dev/null; then
    continue
  fi
  CLIENT="$REPLY"

  REQUEST=""
  IFS= read -r REQUEST <&$CLIENT

  while IFS= read -r HEADER <&$CLIENT; do
    [[ -z "$HEADER" || "$HEADER" == $'\r' ]] && break
  done

  METHOD="${REQUEST%% *}"
  REST="${REQUEST#* }"
  TARGET="${REST%% *}"
  TARGET="${TARGET%%\?*}"
  TARGET="${TARGET#/}"
  [[ -z "$TARGET" ]] && TARGET="index.html"

  if [[ "$METHOD" != "GET" && "$METHOD" != "HEAD" ]]; then
    send_text "$CLIENT" "405 Method Not Allowed" "Method not allowed"
  elif [[ "$TARGET" == *".."* || "$TARGET" == *\\* ]]; then
    send_text "$CLIENT" "403 Forbidden" "Forbidden"
  else
    FILE_PATH="${ROOT_DIR}/${TARGET}"
    if [[ -d "$FILE_PATH" ]]; then
      FILE_PATH="${FILE_PATH}/index.html"
    fi

    if [[ -f "$FILE_PATH" ]]; then
      FILE_SIZE="$(wc -c < "$FILE_PATH" | tr -d ' ')"
      CONTENT_TYPE="$(mime_type "$FILE_PATH")"
      printf 'HTTP/1.1 200 OK\r\n' >&$CLIENT
      printf 'Content-Type: %s\r\n' "$CONTENT_TYPE" >&$CLIENT
      printf 'Content-Length: %s\r\n' "$FILE_SIZE" >&$CLIENT
      printf 'Cache-Control: no-store\r\nConnection: close\r\n\r\n' >&$CLIENT
      [[ "$METHOD" == "GET" ]] && command cat "$FILE_PATH" >&$CLIENT
    else
      send_text "$CLIENT" "404 Not Found" "File not found"
    fi
  fi

  ztcp -c "$CLIENT" 2>/dev/null
done
