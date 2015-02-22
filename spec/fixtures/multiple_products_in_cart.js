var _paq = _paq || [];
(function(){ var u=(('https:' == document.location.protocol) ? 'https://example.com/' : 'http://example.com/');
_paq.push(['setSiteId', 0]);
_paq.push(['setTrackerUrl', u+'piwik.php']);
_paq.push(['addEcommerceItem',
  'SKU-1',
  'RoR Shirt',
  [],
  19.99,
  1
  ]);
_paq.push(['addEcommerceItem',
  'SKU-2',
  'RoR Sticker',
  [],
  0.99,
  1
  ]);
_paq.push(['trackEcommerceCartUpdate', 20.98]);
_paq.push(['trackPageView']);
_paq.push(['enableLinkTracking']);
var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0]; g.type='text/javascript'; g.defer=true; g.async=true; g.src=u+'piwik.js';
s.parentNode.insertBefore(g,s); })();
