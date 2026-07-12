# Changelog

---

❤️ **Support this project:** If you find this add-on useful, please consider supporting its development:
- [GitHub Sponsors](https://github.com/sponsors/Riza-Aslan)
- [PayPal](https://www.paypal.com/paypalme/rizaaslan)

---

## 5.0.0 (2026-07-11)
### ⚠ BREAKING CHANGES

* complete ui overhaul ([#1108](https://github.com/ellite/Wallos/issues/1108))

### Features

* Allow setting beginning of week as Sunday in calendar ([#1010](https://github.com/ellite/Wallos/issues/1010)) ([f01685e](https://github.com/ellite/Wallos/commit/f01685e0eb36690e3ecdcf2f029cae29764e3389))
* complete ui overhaul ([#1108](https://github.com/ellite/Wallos/issues/1108)) ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* dashboard icons image search ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* declarative oidc settings ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* google image search with serpapi ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* grid view for subscriptions ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* more statistics ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* option for the week to start on sunday ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* redesign login / registration pages ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* selfh.st image search ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* subscription details popup ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* translate categories with ai ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* v2.0 api - write endpoints ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))


### Bug Fixes

* calendar occurrences to respect subscription start date ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* escape iCal property values to prevent crlf injection ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* honor configured outbound proxy for logo search without reopening httpoxy SSRF bypass ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* improve background removal feature for logos ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* include todays subscriptions on amount due this month ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* remove hardcode string from the admin page ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* require cron auth guard on storetotalyearlycost.php ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* ssrf via http proxy env var in payments logo search ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))
* validate per-user smtp host against ssrf ([11eaf40](https://github.com/ellite/Wallos/commit/11eaf402e841a628c68a805694227ce66c45f6f3))

## 4.9.6 (2026-06-22)
### Bug Fixes

* account takeover via email-based account linking ([b75f13d](https://github.com/ellite/Wallos/commit/b75f13d0ffa3ed7e77e8e79e4b9fd3fc528c98d3))
* harden oidc state validation and session rotation ([#1071](https://github.com/ellite/Wallos/issues/1071)) ([b75f13d](https://github.com/ellite/Wallos/commit/b75f13d0ffa3ed7e77e8e79e4b9fd3fc528c98d3))
* missing fields when cloning a subscription ([b75f13d](https://github.com/ellite/Wallos/commit/b75f13d0ffa3ed7e77e8e79e4b9fd3fc528c98d3))
* ssrf via oidc token/userInfo url configuration ([b75f13d](https://github.com/ellite/Wallos/commit/b75f13d0ffa3ed7e77e8e79e4b9fd3fc528c98d3))
* ssrf via test email notification ([b75f13d](https://github.com/ellite/Wallos/commit/b75f13d0ffa3ed7e77e8e79e4b9fd3fc528c98d3))
* zip slip path traversal in database restore writes files to webroot ([b75f13d](https://github.com/ellite/Wallos/commit/b75f13d0ffa3ed7e77e8e79e4b9fd3fc528c98d3))

## 4.9.5 (2026-06-06)
### Bug Fixes

* container startup ([#1077](https://github.com/ellite/Wallos/issues/1077)) ([b33d2cb](https://github.com/ellite/Wallos/commit/b33d2cb29350fd512af337e8831e87510edd680b))

## 4.9.4 (2026-06-06)
> ⚠️ **Broken release — container fails to start. Use 4.9.5 instead.**

### Bug Fixes

* restrict migrate.php to CLI and admin session ([85bba48](https://github.com/ellite/Wallos/commit/85bba489f20e00af7dd42593804092a1d33286bb))
* secure unauthenticated db restore endpoint with a setup token ([85bba48](https://github.com/ellite/Wallos/commit/85bba489f20e00af7dd42593804092a1d33286bb))
* validate oidc state parameter to prevent csrf login attack  ([85bba48](https://github.com/ellite/Wallos/commit/85bba489f20e00af7dd42593804092a1d33286bb))

## 4.9.3 (2026-05-27)
### Bug Fixes

* bump version ([#1069](https://github.com/ellite/Wallos/issues/1069)) ([fb96250](https://github.com/ellite/Wallos/commit/fb96250429f7b420b0f388503d6aecf73daca6d4))

## 4.9.2 (2026-05-27)
### Bug Fixes

* build ([#1067](https://github.com/ellite/Wallos/issues/1067)) ([ee62138](https://github.com/ellite/Wallos/commit/ee621382e3722949640b53378b0808b5b4a8f768))

## 4.9.1 (2026-05-27)
### Bug Fixes

* cross-user data isolation issues ([e276147](https://github.com/ellite/Wallos/commit/e276147cab1fd6b1e8e200d94f9200caa9a0376f))
* ensure a user always has an api key generated ([e276147](https://github.com/ellite/Wallos/commit/e276147cab1fd6b1e8e200d94f9200caa9a0376f))
* null pointer on subscription with price 0 ([e276147](https://github.com/ellite/Wallos/commit/e276147cab1fd6b1e8e200d94f9200caa9a0376f))

## 4.9.0 (2026-05-16)
### Features

* allow multiple filters on the settings page ([0fef959](https://github.com/ellite/Wallos/commit/0fef9597ef9eadce725128e454cbd60ec051391d))
* filter by notification status ([0fef959](https://github.com/ellite/Wallos/commit/0fef9597ef9eadce725128e454cbd60ec051391d))
* lifetime subscriptions ([0fef959](https://github.com/ellite/Wallos/commit/0fef9597ef9eadce725128e454cbd60ec051391d))
* rework icons ([0fef959](https://github.com/ellite/Wallos/commit/0fef9597ef9eadce725128e454cbd60ec051391d))
* sort graphs on the statistics page by usage ([0fef959](https://github.com/ellite/Wallos/commit/0fef9597ef9eadce725128e454cbd60ec051391d))


### Bug Fixes

* don't use mbstring ([0fef959](https://github.com/ellite/Wallos/commit/0fef9597ef9eadce725128e454cbd60ec051391d))
* migrations using double quotes ([0fef959](https://github.com/ellite/Wallos/commit/0fef9597ef9eadce725128e454cbd60ec051391d))
* ntfy notifications with strange chars ([0fef959](https://github.com/ellite/Wallos/commit/0fef9597ef9eadce725128e454cbd60ec051391d))
* null array on empty subscription list ([0fef959](https://github.com/ellite/Wallos/commit/0fef9597ef9eadce725128e454cbd60ec051391d))
* open 3 dot menu abone for the subscriptions at the bottom ([0fef959](https://github.com/ellite/Wallos/commit/0fef9597ef9eadce725128e454cbd60ec051391d))

## 4.8.4 (2026-04-27)
### Bug Fixes

* improve date formatting with IntlDateFormatter fallback (b2c565f) ([#1048](https://github.com/ellite/Wallos/issues/1048)) ([8d43623](https://github.com/ellite/Wallos/commit/8d43623da9c27d32c30a219fec84a4724f62c38b))
* missing year for subscription next payment display (ca5823d) ([8d43623](https://github.com/ellite/Wallos/commit/8d43623da9c27d32c30a219fec84a4724f62c38b))

## 4.8.3 (2026-04-26)
### Bug Fixes

* cases on private endpoints where self-xss was possible ([#1045](https://github.com/ellite/Wallos/issues/1045)) ([d4725f3](https://github.com/ellite/Wallos/commit/d4725f36bd967e7dbd622982cdfccbf8567673e2))

## 4.8.2 (2026-04-18)
### Bug Fixes

* logo cut on registration page ([#1040](https://github.com/ellite/Wallos/issues/1040)) ([a95aaad](https://github.com/ellite/Wallos/commit/a95aaadbcc1b32cf9e995bf0b1afecce524b4036))

## 4.8.1 (2026-04-18)
### Bug Fixes

* dns rebinding vulnerability ([e79f28b](https://github.com/ellite/Wallos/commit/e79f28be6be0435fbc93563fb3c0e62206b48e85))
* only allow to use internal urls csrf validation bypass by admin user ([e79f28b](https://github.com/ellite/Wallos/commit/e79f28be6be0435fbc93563fb3c0e62206b48e85))
* ssrf vultenaribility on add subscription ([#1038](https://github.com/ellite/Wallos/issues/1038)) ([e79f28b](https://github.com/ellite/Wallos/commit/e79f28be6be0435fbc93563fb3c0e62206b48e85))

## 4.8.0 (2026-03-23)
### Features

* add openai compatible host for ai recommendations ([99c30e7](https://github.com/ellite/Wallos/commit/99c30e70c8018697ea36babe5e063b3693956600))
* enable ai recommendations at a schedule ([99c30e7](https://github.com/ellite/Wallos/commit/99c30e70c8018697ea36babe5e063b3693956600))
* move update banner to the dashboard ([99c30e7](https://github.com/ellite/Wallos/commit/99c30e70c8018697ea36babe5e063b3693956600))


### Bug Fixes

* handle some ai responses that come in a different format ([99c30e7](https://github.com/ellite/Wallos/commit/99c30e70c8018697ea36babe5e063b3693956600))

## 4.7.3 (2026-03-21)
### Bug Fixes

* image search failing to save ([4fd87c3](https://github.com/ellite/Wallos/commit/4fd87c30144ae9cc38a68d4c3a30df181f8e1827))
* session expiration on pwa on android ([#1023](https://github.com/ellite/Wallos/issues/1023)) ([4fd87c3](https://github.com/ellite/Wallos/commit/4fd87c30144ae9cc38a68d4c3a30df181f8e1827))

## 4.7.2 (2026-03-19)
### Bug Fixes

* password reset tokens now expire after 60 minutes ([90bb618](https://github.com/ellite/Wallos/commit/90bb6186ee4091590b6efdef824c85f2494ff2bb))
* vulnerability would allow to bypass 2fa ([#1021](https://github.com/ellite/Wallos/issues/1021)) ([90bb618](https://github.com/ellite/Wallos/commit/90bb6186ee4091590b6efdef824c85f2494ff2bb))

## 4.7.1 (2026-03-19)
### Bug Fixes

* remove extra line on languages.php causing headers already sent ([#1019](https://github.com/ellite/Wallos/issues/1019)) ([f5c9a34](https://github.com/ellite/Wallos/commit/f5c9a3498ed2df8ae6b225fc63ce01a8ed5ce348))

## 4.7.0 (2026-03-19)
### Features

* add romanian translations ([#1017](https://github.com/ellite/Wallos/issues/1017)) ([e87387f](https://github.com/ellite/Wallos/commit/e87387f0ebb540cd33e6dfda7181db9db650ecef))
* mask ai api key on the settings page ([e87387f](https://github.com/ellite/Wallos/commit/e87387f0ebb540cd33e6dfda7181db9db650ecef))


### Bug Fixes

* ai recommendation numbering when deleting a recommendation ([e87387f](https://github.com/ellite/Wallos/commit/e87387f0ebb540cd33e6dfda7181db9db650ecef))
* calendar ocurrences to respect subscriptions start date ([e87387f](https://github.com/ellite/Wallos/commit/e87387f0ebb540cd33e6dfda7181db9db650ecef))
* logo search ([e87387f](https://github.com/ellite/Wallos/commit/e87387f0ebb540cd33e6dfda7181db9db650ecef))
* retain first and last name when switching language during registration ([e87387f](https://github.com/ellite/Wallos/commit/e87387f0ebb540cd33e6dfda7181db9db650ecef))
* set login cookie to httponly ([e87387f](https://github.com/ellite/Wallos/commit/e87387f0ebb540cd33e6dfda7181db9db650ecef))
* ssrf vulnerability on several endpoints ([e87387f](https://github.com/ellite/Wallos/commit/e87387f0ebb540cd33e6dfda7181db9db650ecef))
* unicode character on the css file ([e87387f](https://github.com/ellite/Wallos/commit/e87387f0ebb540cd33e6dfda7181db9db650ecef))
* xss vulnerability on payment method rename endpoint ([e87387f](https://github.com/ellite/Wallos/commit/e87387f0ebb540cd33e6dfda7181db9db650ecef))

## 4.6.2 (2026-03-05)
### Bug Fixes

* ssrf vulnerability on all test notifications endpoint ([e8a5135](https://github.com/ellite/Wallos/commit/e8a513591dbbf885966e2ef55c38622785b9060d))
* vulnerability allowed to delete avatars from other users ([e8a5135](https://github.com/ellite/Wallos/commit/e8a513591dbbf885966e2ef55c38622785b9060d))
* xss vulnerability on password reset page ([e8a5135](https://github.com/ellite/Wallos/commit/e8a513591dbbf885966e2ef55c38622785b9060d))

## 4.6.1 (2026-02-10)
### Bug Fixes

* vulnerabily on add subscription endpoint ([#991](https://github.com/ellite/Wallos/issues/991)) ([76a53df](https://github.com/ellite/Wallos/commit/76a53df9cb4658123b8f0b7cf1826f1ba7d1c960))

## 4.6.0 (2025-12-20)
### Features

* add catalan translation ([#970](https://github.com/ellite/Wallos/issues/970)) ([f5746e7](https://github.com/ellite/Wallos/commit/f5746e76a5dd6bbda7d52b1a2229c02bb9fad94b))
* add robots.txt to disallow indexing. ([f5746e7](https://github.com/ellite/Wallos/commit/f5746e76a5dd6bbda7d52b1a2229c02bb9fad94b))
* add serverchan notifications. ([f5746e7](https://github.com/ellite/Wallos/commit/f5746e76a5dd6bbda7d52b1a2229c02bb9fad94b))
* notifications for subscription can be triggered up to 180 days before payment date. ([f5746e7](https://github.com/ellite/Wallos/commit/f5746e76a5dd6bbda7d52b1a2229c02bb9fad94b))


### Bug Fixes

* use RFC 5545 compliant date format in iCal exports ([#965](https://github.com/ellite/Wallos/issues/965)) ([b6b0abe](https://github.com/ellite/Wallos/commit/b6b0abed0d916c3ae5a31257f4c0b1a34436ad91))
* use RFC 5545 compliant date format in iCal exports. ([f5746e7](https://github.com/ellite/Wallos/commit/f5746e76a5dd6bbda7d52b1a2229c02bb9fad94b))
* use stable UID for iCal events to prevent duplicates. ([f5746e7](https://github.com/ellite/Wallos/commit/f5746e76a5dd6bbda7d52b1a2229c02bb9fad94b))

## 4.5.0 (2025-10-18)
### Features

* enforce CSRF protection and POST-only policy across endpoints ([#940](https://github.com/ellite/Wallos/issues/940)) ([3247ce2](https://github.com/ellite/Wallos/commit/3247ce2c8768d8e5910f74e5b8eba657b5b05cc1))

## 4.4.1 (2025-10-12)
### Bug Fixes

* get_subscriptions api endpoint was not returning subscriptions ([#937](https://github.com/ellite/Wallos/issues/937)) ([d6329a7](https://github.com/ellite/Wallos/commit/d6329a7af5a48f74b5f1d44a51cdc8c09dc2508b))

## 4.4.0 (2025-10-12)
### Features

* add mattermost notifications ([#923](https://github.com/ellite/Wallos/issues/923)) ([#934](https://github.com/ellite/Wallos/issues/934)) ([5629a31](https://github.com/ellite/Wallos/commit/5629a319bc5eb6cb80abfca06725aed9d2d9df88))
* add openrouter ai endpoint ([#922](https://github.com/ellite/Wallos/issues/922)) ([5629a31](https://github.com/ellite/Wallos/commit/5629a319bc5eb6cb80abfca06725aed9d2d9df88))
* enhance get_subscriptions API with admin access ([#928](https://github.com/ellite/Wallos/issues/928)) ([5629a31](https://github.com/ellite/Wallos/commit/5629a319bc5eb6cb80abfca06725aed9d2d9df88))


### Bug Fixes

* add autocomplete attribute to inputes ([#926](https://github.com/ellite/Wallos/issues/926)) ([5629a31](https://github.com/ellite/Wallos/commit/5629a319bc5eb6cb80abfca06725aed9d2d9df88))

## 4.3.0 (2025-09-15)
### Features

* add health endpoint and healthcheck to container ([#919](https://github.com/ellite/Wallos/issues/919)) ([852cb48](https://github.com/ellite/Wallos/commit/852cb485a65a58c91577b369fb9ea293d370bda8))

## 4.2.0 (2025-09-14)
### Features

* add pushplus notification service  ([#911](https://github.com/ellite/Wallos/issues/911)) ([27ac805](https://github.com/ellite/Wallos/commit/27ac805141c0d170a40c2a7796a589a5ef29544f))
* make container shutdown instant & graceful ([27ac805](https://github.com/ellite/Wallos/commit/27ac805141c0d170a40c2a7796a589a5ef29544f))
* make container shutdown instant & graceful  ([#916](https://github.com/ellite/Wallos/issues/916)) ([27ac805](https://github.com/ellite/Wallos/commit/27ac805141c0d170a40c2a7796a589a5ef29544f))
* option to delete ai recommendations ([27ac805](https://github.com/ellite/Wallos/commit/27ac805141c0d170a40c2a7796a589a5ef29544f))


### Bug Fixes

* parsing ai recommendations from gemini ([#909](https://github.com/ellite/Wallos/issues/909)) ([27ac805](https://github.com/ellite/Wallos/commit/27ac805141c0d170a40c2a7796a589a5ef29544f))

## 4.1.1 (2025-08-13)
### Bug Fixes

* missing apikey validation error on get_monthly_cost api endpoint ([3ecc160](https://github.com/ellite/Wallos/commit/3ecc160ccb73f22367bea427315519876de74a65))
* redirect from dashboard to subscriptions for new users ([3ecc160](https://github.com/ellite/Wallos/commit/3ecc160ccb73f22367bea427315519876de74a65))
* wrong check for disabling password login ([3ecc160](https://github.com/ellite/Wallos/commit/3ecc160ccb73f22367bea427315519876de74a65))

## 4.1.0 (2025-08-11)
### Features

* add at a glance dashboard ([ba6dddf](https://github.com/ellite/Wallos/commit/ba6dddf52601fdbeb18897731beacc48d16043c3))
* add get_oidc_settings endpoint to the api ([ba6dddf](https://github.com/ellite/Wallos/commit/ba6dddf52601fdbeb18897731beacc48d16043c3))
* ai recommendations with chatgpt, gemini or ollama ([ba6dddf](https://github.com/ellite/Wallos/commit/ba6dddf52601fdbeb18897731beacc48d16043c3))
* allow to disable password login when oidc is enabled ([ba6dddf](https://github.com/ellite/Wallos/commit/ba6dddf52601fdbeb18897731beacc48d16043c3))
* display ai recommendations on the dashboard ([ba6dddf](https://github.com/ellite/Wallos/commit/ba6dddf52601fdbeb18897731beacc48d16043c3))
* refactor css colors ([ba6dddf](https://github.com/ellite/Wallos/commit/ba6dddf52601fdbeb18897731beacc48d16043c3))


### Bug Fixes

* accept both api_key and apiKey as parameter on the api ([ba6dddf](https://github.com/ellite/Wallos/commit/ba6dddf52601fdbeb18897731beacc48d16043c3))

## 4.0.0 (2025-07-21)
### ⚠ BREAKING CHANGES

* add oauth / oidc support ([#875](https://github.com/ellite/Wallos/issues/875))

### Features

* add oauth / oidc support ([#875](https://github.com/ellite/Wallos/issues/875)) ([805e688](https://github.com/ellite/Wallos/commit/805e688ec0fac1dbb362e847ed8a4e3e301ee113))
* add oauth/oidc support ([#873](https://github.com/ellite/Wallos/issues/873)) ([c0d53e4](https://github.com/ellite/Wallos/commit/c0d53e4423996595e5c82404af92e077c00eae47))

## 3.3.1 (2025-07-19)
### Bug Fixes

* code of new taiwan dollar ([596cbc4](https://github.com/ellite/Wallos/commit/596cbc42464100dc8c6db5d07c090dab4b767268))
* decoding of header from database on the webhook notifications ([596cbc4](https://github.com/ellite/Wallos/commit/596cbc42464100dc8c6db5d07c090dab4b767268))
* unicode issue on telegram notifications ([#871](https://github.com/ellite/Wallos/issues/871)) ([596cbc4](https://github.com/ellite/Wallos/commit/596cbc42464100dc8c6db5d07c090dab4b767268))

## 3.3.0 (2025-06-09)
### Features

* set todays date on start subscription field for new subscriptions by default ([#848](https://github.com/ellite/Wallos/issues/848)) ([d3fd938](https://github.com/ellite/Wallos/commit/d3fd9387d34f430adb84ef553193b4ad3080c009))


### Bug Fixes

* visual issue with date fields on ios ([#846](https://github.com/ellite/Wallos/issues/846)) ([e2df8f7](https://github.com/ellite/Wallos/commit/e2df8f7e24678f9d62f36f68c94de838fc741913))

## 3.2.0 (2025-06-08)
### Features

* add button to auto fill the next payment date ([48db4e3](https://github.com/ellite/Wallos/commit/48db4e300df6128b7cc0b4e0c86271bfb3159545))
* add first and last names to the user profile ([48db4e3](https://github.com/ellite/Wallos/commit/48db4e300df6128b7cc0b4e0c86271bfb3159545))
* add indonesian language ([#842](https://github.com/ellite/Wallos/issues/842)) ([48db4e3](https://github.com/ellite/Wallos/commit/48db4e300df6128b7cc0b4e0c86271bfb3159545))
* add new currency ([48db4e3](https://github.com/ellite/Wallos/commit/48db4e300df6128b7cc0b4e0c86271bfb3159545))
* Add new currency ([#829](https://github.com/ellite/Wallos/issues/829)) ([288ad45](https://github.com/ellite/Wallos/commit/288ad456564c307018541a09df447898e1d62d26))
* enable IPv6 environments by configuring a dual-stack listen in nginx ([48db4e3](https://github.com/ellite/Wallos/commit/48db4e300df6128b7cc0b4e0c86271bfb3159545))


### Bug Fixes

* vulnerability on test webhook endpoint ([48db4e3](https://github.com/ellite/Wallos/commit/48db4e300df6128b7cc0b4e0c86271bfb3159545))

## 3.1.1 (2025-05-15)
### Bug Fixes

* issue listing prices when uah  was added to the list of currencies ([#823](https://github.com/ellite/Wallos/issues/823)) ([bd20b56](https://github.com/ellite/Wallos/commit/bd20b5697659fc6117113205a3995d7e5f9026c9))

## 3.1.0 (2025-05-08)
### Features

* add danish translation ([0cfefc7](https://github.com/ellite/Wallos/commit/0cfefc7f07056d59ad911f926cc56ff3e6c8e261))


### Bug Fixes

* disable totp with backup code ([0cfefc7](https://github.com/ellite/Wallos/commit/0cfefc7f07056d59ad911f926cc56ff3e6c8e261))
* gotify settings test ([0cfefc7](https://github.com/ellite/Wallos/commit/0cfefc7f07056d59ad911f926cc56ff3e6c8e261))
* vulnerability adding logos from url ([0cfefc7](https://github.com/ellite/Wallos/commit/0cfefc7f07056d59ad911f926cc56ff3e6c8e261))

## 3.0.2 (2025-05-03)
### Bug Fixes

* delete avatar would not work if wallos is on a subfolder ([69c7d52](https://github.com/ellite/Wallos/commit/69c7d52cf8d708bcb046343faa663209c8d36779))
* some strings not using translations on the calendar page ([69c7d52](https://github.com/ellite/Wallos/commit/69c7d52cf8d708bcb046343faa663209c8d36779))
* vulnerability on delete avatar ([69c7d52](https://github.com/ellite/Wallos/commit/69c7d52cf8d708bcb046343faa663209c8d36779))

## 3.0.1 (2025-04-30)
### Bug Fixes

* allow to clear the budget field ([f6b8fb9](https://github.com/ellite/Wallos/commit/f6b8fb9162c5fb4fefa1fbd9cde65c201e96be6c))
* don't show budget alert when budget is 0 ([f6b8fb9](https://github.com/ellite/Wallos/commit/f6b8fb9162c5fb4fefa1fbd9cde65c201e96be6c))

## 3.0.0 (2025-04-27)
### ⚠ BREAKING CHANGES

* simplified webhook notifications without iterator (might break your current webhook settings)

### Features

* simplified webhook notifications without iterator (might break your current webhook settings) ([e0f2048](https://github.com/ellite/Wallos/commit/e0f204803e635400c404529d87e5057c579c8531))
* use mobile style toggles instead of checkboxes ([e0f2048](https://github.com/ellite/Wallos/commit/e0f204803e635400c404529d87e5057c579c8531))
* webhooks can now be used for cancelation notifications ([e0f2048](https://github.com/ellite/Wallos/commit/e0f204803e635400c404529d87e5057c579c8531))


### Bug Fixes

* barely readable placeholder text on textarea on dark the ([e0f2048](https://github.com/ellite/Wallos/commit/e0f204803e635400c404529d87e5057c579c8531))

## 2.52.2 (2025-04-26)
### Bug Fixes

* incorrect headers on the api ([#802](https://github.com/ellite/Wallos/issues/802)) ([af68c11](https://github.com/ellite/Wallos/commit/af68c11abf5d5a64fd7136e1d2e37323d170c77e))

## 2.52.1 (2025-04-26)
### Bug Fixes

* error on statistics page when budget = 0 ([#800](https://github.com/ellite/Wallos/issues/800)) ([b7712dc](https://github.com/ellite/Wallos/commit/b7712dc80d6642a6a33a28adc641f9a4b3263ae6))

## 2.52.0 (2025-04-19)
### Features

* new graph cost vs budget on statistics ([#793](https://github.com/ellite/Wallos/issues/793)) ([6d67319](https://github.com/ellite/Wallos/commit/6d673195ba39f1a52e9ea16bad21221768690e7a))

## 2.51.1 (2025-04-19)
### Bug Fixes

* timezone for cronjobs now comes from TZ env var first ([#791](https://github.com/ellite/Wallos/issues/791)) ([66a1a45](https://github.com/ellite/Wallos/commit/66a1a45f2dc1df99f8292cbb531d569f706eca6d))

## 2.51.0 (2025-04-18)
### Features

* add over budget warnings on the calendar ([88eae10](https://github.com/ellite/Wallos/commit/88eae1002f0cc29a847e95b7698ab713779ec4f4))


### Bug Fixes

* force correct timezone on the cronjobs ([88eae10](https://github.com/ellite/Wallos/commit/88eae1002f0cc29a847e95b7698ab713779ec4f4))

## 2.50.1 (2025-04-16)
### Bug Fixes

* localization on date on browsers not in english ([c7b3fb4](https://github.com/ellite/Wallos/commit/c7b3fb445182e19bc464ac987977bac266628757))

## 2.50.0 (2025-04-16)
### Features

* shorten date displayed on the list of subscriptions ([68f1d47](https://github.com/ellite/Wallos/commit/68f1d4757737de50622bb4b2aeb8f291dec62972))
* use user defined language for the date on the list of subscriptions ([68f1d47](https://github.com/ellite/Wallos/commit/68f1d4757737de50622bb4b2aeb8f291dec62972))


### Bug Fixes

* limit name display, when sub has no logo to two lines ([68f1d47](https://github.com/ellite/Wallos/commit/68f1d4757737de50622bb4b2aeb8f291dec62972))
* use translations on the mobile menu ([68f1d47](https://github.com/ellite/Wallos/commit/68f1d4757737de50622bb4b2aeb8f291dec62972))

## 2.49.1 (2025-04-13)
### Bug Fixes

* version number ([eade2d9](https://github.com/ellite/Wallos/commit/eade2d9919e5d30e7be279f53e278fb746095762))

## 2.49.0 (2025-04-13)
### Features

* show name on mobile view when subscription has no logo ([9eb2907](https://github.com/ellite/Wallos/commit/9eb2907145297e3b7aac54dd5b51451d961f549a))
* show timezone on sendnotification cronjob on admin page ([9eb2907](https://github.com/ellite/Wallos/commit/9eb2907145297e3b7aac54dd5b51451d961f549a))
* use currencyConverter for notifications as well ([9eb2907](https://github.com/ellite/Wallos/commit/9eb2907145297e3b7aac54dd5b51451d961f549a))
* use symbol from db when currencyFormatter does not support the currency ([9eb2907](https://github.com/ellite/Wallos/commit/9eb2907145297e3b7aac54dd5b51451d961f549a))


### Bug Fixes

* date comparison check on sendnotifications cronjob ([9eb2907](https://github.com/ellite/Wallos/commit/9eb2907145297e3b7aac54dd5b51451d961f549a))
* emails with encryption set to none not working without ssl ([9eb2907](https://github.com/ellite/Wallos/commit/9eb2907145297e3b7aac54dd5b51451d961f549a))
* error when not setting custom headers for ntfy ([9eb2907](https://github.com/ellite/Wallos/commit/9eb2907145297e3b7aac54dd5b51451d961f549a))

## 2.48.1 (2025-03-27)
### Bug Fixes

* notifications would also be sent x days after subscription was due in some cases ([ba912a3](https://github.com/ellite/Wallos/commit/ba912a37d1a0d95401a38dabe8f98f29a6aa49db))

## 2.48.0 (2025-03-20)
### Features

* add update notification and release notes to the about page ([3e0e88d](https://github.com/ellite/Wallos/commit/3e0e88d6a2adc46c17773b09dd8684618c979711))
* increase privacy by not sending referrer to external urls ([3e0e88d](https://github.com/ellite/Wallos/commit/3e0e88d6a2adc46c17773b09dd8684618c979711))
* small layout change on the about page ([3e0e88d](https://github.com/ellite/Wallos/commit/3e0e88d6a2adc46c17773b09dd8684618c979711))

## 2.47.1 (2025-03-19)
### Bug Fixes

* small layout inconsistencies on the dashboard ([19d3067](https://github.com/ellite/Wallos/commit/19d30672b2635b6e79eaa6eb5c49100d7a27a63a))

## 2.47.0 (2025-03-19)
### Features

* add filter by renew type ([1bec973](https://github.com/ellite/Wallos/commit/1bec973803e0b3c00d2765bbf80447439127574d))
* add sort by renew type ([1bec973](https://github.com/ellite/Wallos/commit/1bec973803e0b3c00d2765bbf80447439127574d))
* add ukranian translation ([#756](https://github.com/ellite/Wallos/issues/756)) ([1bec973](https://github.com/ellite/Wallos/commit/1bec973803e0b3c00d2765bbf80447439127574d))
* remove "Wallos" text from calendar export ([1bec973](https://github.com/ellite/Wallos/commit/1bec973803e0b3c00d2765bbf80447439127574d))


### Bug Fixes

* ical trigger to spec RFC5545 ([1bec973](https://github.com/ellite/Wallos/commit/1bec973803e0b3c00d2765bbf80447439127574d))
* special chars on calendar exports ([1bec973](https://github.com/ellite/Wallos/commit/1bec973803e0b3c00d2765bbf80447439127574d))
* special chars on notifications ([1bec973](https://github.com/ellite/Wallos/commit/1bec973803e0b3c00d2765bbf80447439127574d))
* state filter not cleared by clear button ([1bec973](https://github.com/ellite/Wallos/commit/1bec973803e0b3c00d2765bbf80447439127574d))

## 2.46.1 (2025-03-06)
### Bug Fixes

* calculation of monthly cost progress graph ([#747](https://github.com/ellite/Wallos/issues/747)) ([77486ec](https://github.com/ellite/Wallos/commit/77486ec92c44b71f69e85b1eafb7f3a98c4a44c1))

## 2.46.0 (2025-02-22)
### Features

* sorting by category or payment method respects order from the settings page ([51b2272](https://github.com/ellite/Wallos/commit/51b22727bf5656a4a263519b5b56adfe6a2d12be))


### Bug Fixes

* access to tmp folder by www-data ([51b2272](https://github.com/ellite/Wallos/commit/51b22727bf5656a4a263519b5b56adfe6a2d12be))

## 2.45.2 (2025-02-05)
### Bug Fixes

* bug setting main currency for the first registered user ([c43b08a](https://github.com/ellite/Wallos/commit/c43b08aa4c45c907f82eb6afe37fd46aa5103654))
* deprecation message ([c43b08a](https://github.com/ellite/Wallos/commit/c43b08aa4c45c907f82eb6afe37fd46aa5103654))
* subscription progress above 100% for disabled subscriptions ([c43b08a](https://github.com/ellite/Wallos/commit/c43b08aa4c45c907f82eb6afe37fd46aa5103654))
* typo on czech translation ([c43b08a](https://github.com/ellite/Wallos/commit/c43b08aa4c45c907f82eb6afe37fd46aa5103654))
* use first currency on the list of currencies if user has not selected a main currency ([c43b08a](https://github.com/ellite/Wallos/commit/c43b08aa4c45c907f82eb6afe37fd46aa5103654))
* use gd if imagick is not available ([c43b08a](https://github.com/ellite/Wallos/commit/c43b08aa4c45c907f82eb6afe37fd46aa5103654))

## 2.45.1 (2025-01-28)
### Bug Fixes

* improve czech translation ([e2dc269](https://github.com/ellite/Wallos/commit/e2dc2696310159900c1f8fbe0a090e66b29b778d))
* improve japanese translation ([#713](https://github.com/ellite/Wallos/issues/713)) ([e2dc269](https://github.com/ellite/Wallos/commit/e2dc2696310159900c1f8fbe0a090e66b29b778d))
* improve traditional chinese translation ([e2dc269](https://github.com/ellite/Wallos/commit/e2dc2696310159900c1f8fbe0a090e66b29b778d))
* setting pgid and puid for the container ([e2dc269](https://github.com/ellite/Wallos/commit/e2dc2696310159900c1f8fbe0a090e66b29b778d))

## 2.45.0 (2025-01-19)
### Features

* add czech translations ([#701](https://github.com/ellite/Wallos/issues/701)) ([426fdfa](https://github.com/ellite/Wallos/commit/426fdfa5c79d32c7d5a0722a0590d39547cfd1fa))

## 2.44.1 (2025-01-19)
### Bug Fixes

* error setting date of last exchange rates update ([#699](https://github.com/ellite/Wallos/issues/699)) ([d2f68c4](https://github.com/ellite/Wallos/commit/d2f68c457e9b1328caf983ddc6e2827430855aa6))

## 2.44.0 (2025-01-12)
### Features

* allow notifications on due date ([87f148d](https://github.com/ellite/Wallos/commit/87f148d1745bec19f5713b8a367a3615871e6e33))


### Bug Fixes

* don't expose disabled notifications to ical feed ([87f148d](https://github.com/ellite/Wallos/commit/87f148d1745bec19f5713b8a367a3615871e6e33))
* email notification test always sending to admins email ([87f148d](https://github.com/ellite/Wallos/commit/87f148d1745bec19f5713b8a367a3615871e6e33))

## 2.43.1 (2025-01-12)
### Bug Fixes

* edit / delete subscription menu not accessible ([#689](https://github.com/ellite/Wallos/issues/689)) ([b668d37](https://github.com/ellite/Wallos/commit/b668d37d38f799ee0dda5a69a4824d03dd21e1bc))

## 2.43.0 (2025-01-11)
### Features

* new api endpoint that returns the version ([ff13fcb](https://github.com/ellite/Wallos/commit/ff13fcb6547ec4a9c972a2c0f0b6f42d69620f8b))
* option to show progress of subscription cycle ([ff13fcb](https://github.com/ellite/Wallos/commit/ff13fcb6547ec4a9c972a2c0f0b6f42d69620f8b))


### Bug Fixes

* currency symbol for monthly budget ([ff13fcb](https://github.com/ellite/Wallos/commit/ff13fcb6547ec4a9c972a2c0f0b6f42d69620f8b))

## 2.42.2 (2024-12-21)
### Bug Fixes

* version number ([#668](https://github.com/ellite/Wallos/issues/668)) ([683a366](https://github.com/ellite/Wallos/commit/683a3662ff998066f5d8de3be88e4d40d766442a))

## 2.42.1 (2024-12-21)
### Bug Fixes

* remove debug echo on stats page ([#666](https://github.com/ellite/Wallos/issues/666)) ([d9a2488](https://github.com/ellite/Wallos/commit/d9a24885ffbbdb3c08d9015804eea8cb0fea6cea))

## 2.42.0 (2024-12-21)
### Features

* add total monthly cost trend graph to the statistics page ([e7185f9](https://github.com/ellite/Wallos/commit/e7185f92578b3103d097b12b8c4313635f263d9f))
* allow email notifications without authentication ([e7185f9](https://github.com/ellite/Wallos/commit/e7185f92578b3103d097b12b8c4313635f263d9f))


### Bug Fixes

* don't update next payment date for disabled subscriptions ([e7185f9](https://github.com/ellite/Wallos/commit/e7185f92578b3103d097b12b8c4313635f263d9f))
* xss security vulnerability with the avatar selection ([e7185f9](https://github.com/ellite/Wallos/commit/e7185f92578b3103d097b12b8c4313635f263d9f))

## 2.41.0 (2024-12-11)
### Features

* add payment cycle to csv/json export ([5e6bc90](https://github.com/ellite/Wallos/commit/5e6bc903bcd95580ed58f744977d92c6330b3d9f))
* run db migration after importing db ([5e6bc90](https://github.com/ellite/Wallos/commit/5e6bc903bcd95580ed58f744977d92c6330b3d9f))
* run db migration after restoring database ([5e6bc90](https://github.com/ellite/Wallos/commit/5e6bc903bcd95580ed58f744977d92c6330b3d9f))
* store weekly the total yearly cost of subscriptions ([5e6bc90](https://github.com/ellite/Wallos/commit/5e6bc903bcd95580ed58f744977d92c6330b3d9f))


### Bug Fixes

* double encoding in statistics labels ([5e6bc90](https://github.com/ellite/Wallos/commit/5e6bc903bcd95580ed58f744977d92c6330b3d9f))

## 2.40.0 (2024-12-10)
### Features

* add dutch translation ([#655](https://github.com/ellite/Wallos/issues/655)) ([b5a9880](https://github.com/ellite/Wallos/commit/b5a98806d1f453180ce15724fa198d248177e488))

## 2.39.1 (2024-12-06)
### Bug Fixes

* svg error on calendar page ([#650](https://github.com/ellite/Wallos/issues/650)) ([8ba79c0](https://github.com/ellite/Wallos/commit/8ba79c0725815c6de8458c74961bbdf23a7d3e9d))

## 2.39.0 (2024-12-06)
### Features

* add icalendar subscription ([f5ddbff](https://github.com/ellite/Wallos/commit/f5ddbff0c1e0be676604390101c56c04c778f56a))

## 2.38.3 (2024-12-06)
### Bug Fixes

* vulnerability on the restore database endpoints ([3b2de8b](https://github.com/ellite/Wallos/commit/3b2de8b7c22090afdf7115c25fd8b497a5626ea3))

## 2.38.2 (2024-11-19)
### Bug Fixes

* logo search positioned below other elements ([#637](https://github.com/ellite/Wallos/issues/637)) ([72f7e57](https://github.com/ellite/Wallos/commit/72f7e5791423c45f910a791b20aafba301d0172f))

## 2.38.1 (2024-11-17)
### Bug Fixes

* bug introduced on 2.38.0 on the subscriptions dashboard ([#634](https://github.com/ellite/Wallos/issues/634)) ([f63c543](https://github.com/ellite/Wallos/commit/f63c543cdd7512b216004db3b279884dbda87ce4))

## 2.38.0 (2024-11-17)
### Features

* add option for manual/automatic renewals ([6e44a26](https://github.com/ellite/Wallos/commit/6e44a26703486d0ba30ee6ae8d3c46bfc3c6630a))
* add some leeway for totp codes ([6e44a26](https://github.com/ellite/Wallos/commit/6e44a26703486d0ba30ee6ae8d3c46bfc3c6630a))
* add start date to subscriptions ([6e44a26](https://github.com/ellite/Wallos/commit/6e44a26703486d0ba30ee6ae8d3c46bfc3c6630a))


### Bug Fixes

* layout issue with subscriptions list during search ([6e44a26](https://github.com/ellite/Wallos/commit/6e44a26703486d0ba30ee6ae8d3c46bfc3c6630a))

## 2.37.1 (2024-11-15)
### Bug Fixes

* version mismatch ([#627](https://github.com/ellite/Wallos/issues/627)) ([c4a9b16](https://github.com/ellite/Wallos/commit/c4a9b1627fbc7278398bf2d8bf7cae2934d349ca))

## 2.37.0 (2024-11-15)
### Features

* add monthly statistics to the calendar page ([f085f8a](https://github.com/ellite/Wallos/commit/f085f8adece3af2548858f665db16d4843d3e622))


### Bug Fixes

* notifications being sent on the wrong day ([f085f8a](https://github.com/ellite/Wallos/commit/f085f8adece3af2548858f665db16d4843d3e622))

## 2.36.2 (2024-11-03)
### Bug Fixes

* only show swipe hint on mobile screens ([#612](https://github.com/ellite/Wallos/issues/612)) ([bd5e351](https://github.com/ellite/Wallos/commit/bd5e3511829a798ab47ca5e9c9d080aae45ae1a0))

## 2.36.1 (2024-11-03)
### Bug Fixes

* version number ([#610](https://github.com/ellite/Wallos/issues/610)) ([4bd40f1](https://github.com/ellite/Wallos/commit/4bd40f1c561e979322375b95aeccccd18c4780fd))

## 2.36.0 (2024-11-03)
### Features

* add hint for mobile swipe action ([#608](https://github.com/ellite/Wallos/issues/608)) ([49666f8](https://github.com/ellite/Wallos/commit/49666f867cdbaa4d4c0c1551d0b4b3023830606a))

## 2.35.0 (2024-11-01)
### Features

* new menu icons ([28444ab](https://github.com/ellite/Wallos/commit/28444abef1cee338e41e57cbf6f13666b917bbde))
* swipe subscription for actions on the experimental mobile navigation ([28444ab](https://github.com/ellite/Wallos/commit/28444abef1cee338e41e57cbf6f13666b917bbde))

## 2.34.0 (2024-10-31)
### Features

* link version update banner to github release ([f007adf](https://github.com/ellite/Wallos/commit/f007adf9658eb1fd095c2716e4146130535f6cb7))
* only show filters that are actually used ([f007adf](https://github.com/ellite/Wallos/commit/f007adf9658eb1fd095c2716e4146130535f6cb7))


### Bug Fixes

* filters for categories and payment method respect order from settings ([f007adf](https://github.com/ellite/Wallos/commit/f007adf9658eb1fd095c2716e4146130535f6cb7))

## 2.33.1 (2024-10-30)
### Bug Fixes

* improve localization ([6480f87](https://github.com/ellite/Wallos/commit/6480f8744094d5ce0f05d7d155925540ac73b156))
* layout issue on the settings page ([#598](https://github.com/ellite/Wallos/issues/598)) ([6480f87](https://github.com/ellite/Wallos/commit/6480f8744094d5ce0f05d7d155925540ac73b156))

## 2.33.0 (2024-10-29)
### Features

* replacement for disabled subscriptions, to more accurately calculate savings ([5c92528](https://github.com/ellite/Wallos/commit/5c9252880837a7886c903ddc7ae92c8fed29b452))

## 2.32.0 (2024-10-27)
### Features

* settings to allow to ignore certificates for some notification methods ([2a0e665](https://github.com/ellite/Wallos/commit/2a0e665e77eca804fa70dafc1a3a0010eb9da270))

## 2.31.1 (2024-10-25)
### Bug Fixes

* add missing {{days_until}} variable to string version of the webhook ([ebc7b83](https://github.com/ellite/Wallos/commit/ebc7b83e9a0a32aecf3b1aa933408bf9b6baea3a))
* display actual error message when email test fails ([ebc7b83](https://github.com/ellite/Wallos/commit/ebc7b83e9a0a32aecf3b1aa933408bf9b6baea3a))

## 2.31.0 (2024-10-22)
### Features

* handle webhook payload as string if it is not a json object ([#583](https://github.com/ellite/Wallos/issues/583)) ([ee834d6](https://github.com/ellite/Wallos/commit/ee834d6198fa3315facd23a734655adf391bb736))

## 2.30.1 (2024-10-14)
### Bug Fixes

* verify correct path before creating logos folder ([782ebcd](https://github.com/ellite/Wallos/commit/782ebcd64fc947ea82eabaac6bc26a32676271a1))

## 2.30.0 (2024-10-13)
### Features

* add vietnamese translation ([#573](https://github.com/ellite/Wallos/issues/573)) ([45ff10f](https://github.com/ellite/Wallos/commit/45ff10f953f4af681252ed4d77c32b375f9c396c))

## 2.29.2 (2024-10-11)
### Bug Fixes

* xss issue on the dashboard ([#568](https://github.com/ellite/Wallos/issues/568)) ([e642129](https://github.com/ellite/Wallos/commit/e6421296aa708b02c468b10e3c9d0f28012c1282))

## 2.29.1 (2024-10-11)
### Bug Fixes

* mysql injection vulnerability ([3d6a8c3](https://github.com/ellite/Wallos/commit/3d6a8c340843230eff97b459e85efbea55aac01f))
* new profile page not being cached by service worker ([3d6a8c3](https://github.com/ellite/Wallos/commit/3d6a8c340843230eff97b459e85efbea55aac01f))

## 2.29.0 (2024-10-09)
### Features

* add url and notes as variables for the notifications webhook ([790defb](https://github.com/ellite/Wallos/commit/790defb2b1d1cd3d8c93738155edb19f96d0aa2a))


### Bug Fixes

* bug when looping multiple subscriptions on the notifications webhook ([790defb](https://github.com/ellite/Wallos/commit/790defb2b1d1cd3d8c93738155edb19f96d0aa2a))

## 2.28.0 (2024-10-07)
### Features

* get admin setting api endpoint ([07d456a](https://github.com/ellite/Wallos/commit/07d456a9c3d9cc3eb9ae80edb666caa103cababe))
* get categories endpoint ([07d456a](https://github.com/ellite/Wallos/commit/07d456a9c3d9cc3eb9ae80edb666caa103cababe))
* get currencies endpoint ([07d456a](https://github.com/ellite/Wallos/commit/07d456a9c3d9cc3eb9ae80edb666caa103cababe))
* get fixer api endpoint ([07d456a](https://github.com/ellite/Wallos/commit/07d456a9c3d9cc3eb9ae80edb666caa103cababe))
* get household api endpoint ([07d456a](https://github.com/ellite/Wallos/commit/07d456a9c3d9cc3eb9ae80edb666caa103cababe))
* get notifications api endpoint ([07d456a](https://github.com/ellite/Wallos/commit/07d456a9c3d9cc3eb9ae80edb666caa103cababe))
* get payment methods api endpoint ([07d456a](https://github.com/ellite/Wallos/commit/07d456a9c3d9cc3eb9ae80edb666caa103cababe))
* get settings api endpoint ([07d456a](https://github.com/ellite/Wallos/commit/07d456a9c3d9cc3eb9ae80edb666caa103cababe))
* get subscriptions api endpoint ([07d456a](https://github.com/ellite/Wallos/commit/07d456a9c3d9cc3eb9ae80edb666caa103cababe))
* get user api endpoint ([07d456a](https://github.com/ellite/Wallos/commit/07d456a9c3d9cc3eb9ae80edb666caa103cababe))

## 2.27.3 (2024-10-05)
### Bug Fixes

* missing folders on baremetal installation ([#554](https://github.com/ellite/Wallos/issues/554)) ([03f34d1](https://github.com/ellite/Wallos/commit/03f34d1aee3f74c3bf9c53c04c1494106be4bb47))
* missing fonts ([03f34d1](https://github.com/ellite/Wallos/commit/03f34d1aee3f74c3bf9c53c04c1494106be4bb47))

## 2.27.2 (2024-10-04)
### Bug Fixes

* bump version ([#546](https://github.com/ellite/Wallos/issues/546)) ([c5460bd](https://github.com/ellite/Wallos/commit/c5460bd79bdd056e788774ac52cfd4262eada5e7))

## 2.27.1 (2024-10-04)
### Bug Fixes

* add missing assets to the service worker ([#542](https://github.com/ellite/Wallos/issues/542)) ([0251da2](https://github.com/ellite/Wallos/commit/0251da23f4254420a471fcd4c4951d0d0b1bb4df))

## 2.27.0 (2024-10-04)
### Features

* api endpoint to calculate monthly cost ([a173d27](https://github.com/ellite/Wallos/commit/a173d2765fd2a1a641f32fbea198775b1bdc0b00))
* fisrt api endpoint ([a173d27](https://github.com/ellite/Wallos/commit/a173d2765fd2a1a641f32fbea198775b1bdc0b00))
* redesigned experimental mobile navigation menu ([a173d27](https://github.com/ellite/Wallos/commit/a173d2765fd2a1a641f32fbea198775b1bdc0b00))
* split settings page into settings and profile page ([a173d27](https://github.com/ellite/Wallos/commit/a173d2765fd2a1a641f32fbea198775b1bdc0b00))
* user has api key available on profile page ([a173d27](https://github.com/ellite/Wallos/commit/a173d2765fd2a1a641f32fbea198775b1bdc0b00))


### Bug Fixes

* small fixes and typos ([a173d27](https://github.com/ellite/Wallos/commit/a173d2765fd2a1a641f32fbea198775b1bdc0b00))

## 2.26.0 (2024-09-29)
### Features

* add mobile menu navigation to experimental settings ([1dbba18](https://github.com/ellite/Wallos/commit/1dbba18446ac53568492af9d2aee3f90db7168ca))
* use browsers locale to set dates on the dashboard ([1dbba18](https://github.com/ellite/Wallos/commit/1dbba18446ac53568492af9d2aee3f90db7168ca))

## 2.25.0 (2024-09-28)
### Features

* add 2fa support ([#525](https://github.com/ellite/Wallos/issues/525)) ([2f16ab3](https://github.com/ellite/Wallos/commit/2f16ab3fdf89b8ba6b1010510d8b169aad425f38))

## 2.24.1 (2024-09-23)
### Bug Fixes

* small layout issue on the settings page ([0623ceb](https://github.com/ellite/Wallos/commit/0623cebe67182b493770615c518977907e11d359))

## 2.24.0 (2024-09-18)
### Features

* add button to clean up search field ([da3ee78](https://github.com/ellite/Wallos/commit/da3ee782f13c1eaa98a85de5dbe33714d173a323))


### Bug Fixes

* cases where theme and sort cookies could be missing ([da3ee78](https://github.com/ellite/Wallos/commit/da3ee782f13c1eaa98a85de5dbe33714d173a323))
* position of dropdown on rtl layout ([da3ee78](https://github.com/ellite/Wallos/commit/da3ee782f13c1eaa98a85de5dbe33714d173a323))

## 2.23.2 (2024-09-04)
### Bug Fixes

* sort order after edit subscription in case the cookie is missing ([87809fe](https://github.com/ellite/Wallos/commit/87809fea71b92c7518173fedd189d7e76ce11bfb))

## 2.23.1 (2024-09-01)
### Bug Fixes

* warning on top of dashboard page ([#512](https://github.com/ellite/Wallos/issues/512)) ([9056722](https://github.com/ellite/Wallos/commit/905672243b75e6b3d367d439bdbbb37d1b5ae0fa))

## 2.23.0 (2024-09-01)
### Features

* add multi email recipients ([fed0192](https://github.com/ellite/Wallos/commit/fed0192394e77409dae04d4ab3cdda0ba0c578a4))
* add option for also showing the original price on the dashboard ([fed0192](https://github.com/ellite/Wallos/commit/fed0192394e77409dae04d4ab3cdda0ba0c578a4))
* open edit form after cloning subscription ([fed0192](https://github.com/ellite/Wallos/commit/fed0192394e77409dae04d4ab3cdda0ba0c578a4))
* select multiple filters on the dashboard ([fed0192](https://github.com/ellite/Wallos/commit/fed0192394e77409dae04d4ab3cdda0ba0c578a4))


### Bug Fixes

* export.php csv header typo ([#499](https://github.com/ellite/Wallos/issues/499)) ([6e96c5d](https://github.com/ellite/Wallos/commit/6e96c5d4b0c7264ab37a85e9a8b8062f96f69c5c))
* typo on export subscriptions to csv ([fed0192](https://github.com/ellite/Wallos/commit/fed0192394e77409dae04d4ab3cdda0ba0c578a4))

## 2.22.1 (2024-08-11)
### Bug Fixes

* inline items in subscription form out of place ([#489](https://github.com/ellite/Wallos/issues/489)) ([3f33ba0](https://github.com/ellite/Wallos/commit/3f33ba0310af0c903db9bef1dd6668146219142c))

## 2.22.0 (2024-08-09)
### Features

* admin can manually trigger cronjobs ([1946ac9](https://github.com/ellite/Wallos/commit/1946ac9855696892b9a0790d46623614aa9aab2c))


### Bug Fixes

* only allow the system and admin to run the cronjobs ([1946ac9](https://github.com/ellite/Wallos/commit/1946ac9855696892b9a0790d46623614aa9aab2c))
* reduce size of the log files of the cronjobs ([1946ac9](https://github.com/ellite/Wallos/commit/1946ac9855696892b9a0790d46623614aa9aab2c))
