// ParsleyConfig definition if not already set
window.ParsleyConfig = window.ParsleyConfig || {};
window.ParsleyConfig.i18n = window.ParsleyConfig.i18n || {};

// Define then the messages
window.ParsleyConfig.i18n.cs = jQuery.extend(window.ParsleyConfig.i18n.cs || {}, {
  defaultMessage: "Tato položka je neplatná.",
  type: {
    email:        "Tato položka musí být e-mailová adresa.",
    url:          "Tato položka musí být platná URL adresa.",
    number:       "Tato položka musí být číslo.",
    integer:      "Tato položka musí být cele číslo.",
    digits:       "Tato položka musí být kladne cele číslo.",
    alphanum:     "Tato položka musí být alfanumerická."
  },
  notblank:       "Tato položka nesmí být prázdná.",
  required:       "Tato položka je povinná.",
  pattern:        "Tato položka je neplatná.",
  min:            "Tato položka musí být větší nebo rovna %s.",
  max:            "Tato položka musí být menší nebo rovna %s.",
  range:          "Tato položka musí být v rozsahu od %s do %s.",
  minlength:      "Tato položka musí mít nejmeně %s znaků.",
  maxlength:      "Tato položka musí mít nejvíce %s znaků.",
  length:         "Tato položka musí mít delku od %s do %s znaků.",
  mincheck:       "Je nutne vybrat alespoň %s možností.",
  maxcheck:       "Je nutne vybrat nejvýše %s možností.",
  check:          "Je nutne vybrat od %s do %s možností.",
  equalto:        "Tato položka musí být stejná."
});

// If file is loaded after Parsley main file, auto-load locale
if ('undefined' !== typeof window.ParsleyValidator)
  window.ParsleyValidator.addCatalog('cs', window.ParsleyConfig.i18n.cs, true);
