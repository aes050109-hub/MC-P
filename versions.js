'use strict';
const moduleSelect = document.getElementById('module');
const versionSelect = document.getElementById('version');
function draw() {
  const rx = moduleSelect.value === 'rx';
  const version = versionSelect.value;
  const prefix = rx ? 'prescription' : 'certificate';
  const title = rx ? 'Request a repeat' : 'Request a certificate';
  const preview = document.getElementById('preview');
  if (version === '2' || version === 'mobile') {
    preview.innerHTML = `<p>Current working page. Use fictional information.</p>
      <iframe title="${title} prototype" src="../${prefix}-request.html"
        class="frame-demo" style="${version === '2' ? 'width:100%;height:1080px' : ''}"></iframe>`;
    return;
  }
  const initial = version === '0';
  const fields = rx ? ['Medicine', 'Pharmacy'] : ['Purpose', 'Start date', 'End date'];
  preview.innerHTML = `<div class="panel"><p class="eyebrow">${initial ? 'Initial concept' : 'Revision 1'}</p>
    <div class="row"><strong>Online GP Clinic</strong><span>Home / Patient services</span></div>
    <hr><h2>${title}</h2>${initial ? '' : '<p>1 Details &nbsp; 2 Review &nbsp; 3 Confirmation</p>'}
    <div class="${initial ? '' : 'columns'}"><div>
    ${fields.map(f => `<p><strong>${f}</strong></p><div style="height:46px;border:1px solid #718679;
      border-radius:6px;margin-bottom:16px;background:#f3f7f5">&nbsp;</div>`).join('')}
    ${initial ? '' : '<p>GP review is required. No approval is guaranteed.</p>'}
    <div class="actions"><span class="button secondary">${initial ? 'Back' : 'Cancel'}</span>
    <span class="button">${initial ? 'Submit' : 'Review request'}</span></div></div>
    ${initial ? '' : `<aside><h3>Example fee</h3><p class="price">NZ$${rx ? '20.00' : '25.00'}</p>
    <p>No payment in the prototype.</p><p>Only request details are collected.</p></aside>`}</div>
    </div><p class="hint">Static design exploration. Controls in this view are illustrative.</p>`;
}
moduleSelect.addEventListener('change', draw);
versionSelect.addEventListener('change', draw);
draw();
