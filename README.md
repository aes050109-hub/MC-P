# Online GP Clinic patient service modules

This package contains Shuohan's Prescriptions and Medical Certificates contribution.
It is a medium fidelity, front end course prototype. It is not a live medical system.
All medicines, pharmacies, patient records and prices are fictional examples.

## 在 VS Code 中直接运行

This macOS version requires no Node.js, npm, Python or VS Code extension. It uses a built-in
VS Code task and the networking module already included with macOS zsh.

1. Unzip the package and choose File > Open Folder in VS Code. Open the
   `online-gp-clinic` folder itself, not an individual HTML file.
2. Choose Terminal > Run Build Task, or press Command+Shift+B.
3. If prompted, select `Run Online GP Website (No Node)`.
4. The default browser opens at `http://localhost:5500/`. The address does not expose the
   Downloads path.
5. Click Manage prescriptions or Manage certificates to begin the demonstration.
6. Keep the VS Code terminal open while using the site. Stop it with Control+C or the terminal
   trash button.

Do not use Run Code on `index.html`; HTML is not an executable program. The supplied Build Task
is the direct, extension-free VS Code run command for this package.

Keep all files together. `app.js` and `styles.css` must remain beside the root HTML files. Browser sessionStorage stores the fictional demonstration state; Reset demo clears it.

## Files and page scope

- index.html: local entry page; replace with the group's actual home page when integrating.
- prescriptions.html: prescription overview and request list.
- prescription-request.html: select an example medicine and pharmacy.
- prescription-review.html: review details and explicitly confirm.
- prescription-confirmation.html: pending status and demo receipt.
- medical-certificates.html: certificate overview and request list.
- certificate-request.html: purpose, dates and related consultation.
- certificate-review.html: review details and explicitly confirm.
- certificate-confirmation.html: pending status and demo receipt.
- styles.css: shared colour, type, layout and responsive rules.
- app.js: shared navigation, validation, session state and interactions.
- iterations/versions.html and versions.js: initial concept, revision 1 and revision 2 for two pages.

There are eight module pages. The entry page and version gallery are not extra service pages.
The group needs 15–20 planned pages in total. The accompanying report proposes a 20-page
whole-site structure and clearly identifies the 12 pages owned by other team members.

## Integration

The four TEAM values at the top of app.js define home, appointments, messages and profile
paths. Set each empty value to the actual filename provided by that page's author.
Until then, these buttons open a clearly labelled handoff message rather than a broken link.
Global Services, FAQ, How it works and Contact open supporting demo dialogs. Replace them
with the group's real destinations at integration. Those dialogs are not counted as pages.

Edit --ink, --teal and other CSS variables to match the group's final palette. Edit RX.fee
and MC.fee in app.js only after the clinic has approved real pricing. Prices remain labelled
as examples in this prototype. Do not imply that submitting a request issues a clinical document.

## Data and behaviour

Demo state is saved in sessionStorage under online-gp-course-demo-v1. No backend, network
submission, payment, login, clinical approval, pharmacy dispatch or certificate generation exists.
Selection fields use fixed fictional values. Dates must be valid and the end date cannot precede
the start date. A changed medicine or an uncompleted consultation routes to the team booking
handoff. Consent is unchecked until explicitly selected. Review pages require a valid draft.
Confirmation pages require a saved request. Requests stay at Awaiting GP review.

The receipt is a plain text demo acknowledgement, not a prescription or medical certificate.
Use only fictional data. A live implementation needs authenticated server-side records and
clinical workflows; client-side validation and browser storage are not sufficient for that use.

## Iteration evidence

The supplied personas and classroom examples inform the revisions. No user testing of these
new pages has been conducted. The version gallery is a transparent design exploration, not
historical evidence. Use the accompanying test worksheet to record real participant feedback,
make the resulting changes, and include that evidence in the group's final report.

## Sources

Supplied group plan: INFO期中小组.pdf, especially pp. 3–6, 10–15 and 20–23.
Supplied classroom examples: assignmenthelp2.pptx, slides 1–9.
Nielsen: https://www.nngroup.com/articles/ten-usability-heuristics/
W3C forms: https://www.w3.org/WAI/tutorials/forms/
WCAG 2.2: https://www.w3.org/TR/WCAG22/
Medical Council: https://www.mcnz.org.nz/our-standards/current-standards/medical-certification/
Medical Council: https://www.mcnz.org.nz/our-standards/current-standards/telehealth/

No external pictures, fonts, icon libraries or framework packages are needed to run the prototype.
