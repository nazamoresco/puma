'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "0f33f9cb8ba20cfa1a5bf26feccdcc16",
"main.dart.mjs": "ecb0c5e45cfb40148bc54334c946dfde",
"index.html": "582ad0af0605ee9d8ef920933914b246",
"/": "582ad0af0605ee9d8ef920933914b246",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "56cf2f942784125a5f4f3e0816ee30c1",
"assets/assets/images/parcela_infectada_4.webp": "bb660b6a119c27f828b2b94b5f36a344",
"assets/assets/images/0_tierra_pelada.webp": "5fd85e7c7f97a85a1f1072f911c95d1c",
"assets/assets/images/sapo_512_1.webp": "7fa97c30fb55a801cb745a296ae1ba4a",
"assets/assets/images/maiz_0.webp": "4893784927f71684da9ef7b7a89ba976",
"assets/assets/images/estaciones_INVIERNO.webp": "5222166a70db7be5b8a6b16f92fd976a",
"assets/assets/images/icono_lechuga.webp": "a73053aad4536578994f9f1643e8f0e3",
"assets/assets/images/parcela_infectada_1.webp": "219f0676d7b5333141b978b5c6660820",
"assets/assets/images/pie_de_dialogo_4.webp": "82019141f63fb86158ba3833def45c8d",
"assets/assets/images/icono_tomate.webp": "9a428057eea6f32f0ab742393cc8ea6d",
"assets/assets/images/1080_pasto.webp": "d70797616f90f1ab041b1c37327a738f",
"assets/assets/images/icono_cebolla.webp": "bb7a944b77f6bf8febd95ab0d6b8f92b",
"assets/assets/images/maiz_2.webp": "6118b2debc0781c53d44108bbad55ad2",
"assets/assets/images/COCINA_fondo_sapo.webp": "a154e6b7a8ef289a666416804303204d",
"assets/assets/images/papa_3.webp": "a77d205c1dd8790406fbecbe7dfbab4f",
"assets/assets/images/zapallo_3.webp": "5fc82371d9b8d5d510bc38a46546199b",
"assets/assets/images/cebolla_3.webp": "7e9434ecd790139255da60b15907c36d",
"assets/assets/images/zapallo_1.webp": "cf4f39d1024be3d8923af1fad77d3d8e",
"assets/assets/images/personaje_512.webp": "7c4b7e67125ab3e500e21e72e016236e",
"assets/assets/images/brocoli_2.webp": "502bf0df63a83855d1eea75c0a17529a",
"assets/assets/images/receta_cazuela_papas_zanahorias.webp": "0123dab4a3871a62fec21cb248d9778d",
"assets/assets/images/lechuga_3.webp": "0582f566302ed6a44ba95379b62e1433",
"assets/assets/images/zanahoria_1.webp": "9e65c5c4912bcd41b53f13275752d689",
"assets/assets/images/pepino_2.webp": "fc6f2264e8bd5edbec1398337985d1a9",
"assets/assets/images/maiz_1.webp": "cb99601eba7719ec218354193f090218",
"assets/assets/images/pie_de_dialogo_2.webp": "75c5da640fc285ae513b8872afac8440",
"assets/assets/images/lechuga_2.webp": "70bbed584ce821d98a5d6ae81aa4feef",
"assets/assets/images/sapo_512_2.webp": "20add5e5e1f759c318ded17dc9032f01",
"assets/assets/images/maiz_3.webp": "75879188621f66de587121d9a8b9fa6a",
"assets/assets/images/icono_fumigar_2.webp": "3c1ca6f90da8110288b016e2adfb2754",
"assets/assets/images/icono_brocoli.webp": "201bde69c7a64ab0ab14139ca39ae3cd",
"assets/assets/images/papa_2.webp": "493f4775ea5373b93293a7358ea1c583",
"assets/assets/images/receta_ensalada.webp": "be03e525e0f72dad7dc0db7608383e16",
"assets/assets/images/zanahoria_0.webp": "9c0bb0e96a5b30a6152b773fc8f1106c",
"assets/assets/images/cebolla_1.webp": "711c1df01d001936a45aff1fee21560b",
"assets/assets/images/cultivo_muerto.webp": "0308b2e732483ce684c42d1079cfa189",
"assets/assets/images/receta_ensalada_quinoa_brocoli.webp": "39cf04ed96a5c1982ae91d3c8886467a",
"assets/assets/images/relojito.webp": "ce6d27880640ffbb60fbf143d3358da3",
"assets/assets/images/icono_mercado_semillas.webp": "e35c426f391d5944d2bf7fde5720b924",
"assets/assets/images/parcela_infectada_3.webp": "71a8408950a9535fc08f26c74bcac6b7",
"assets/assets/images/receta_alcachofas_rellenas.webp": "faafe7a9ddbe717a166b5509a5535df2",
"assets/assets/images/tutorial_1.webp": "d6e37a081aca3bf8a63e3b4522a6feba",
"assets/assets/images/receta_tortilla.webp": "cd733eedeaa46cc79c14136b9333ea4f",
"assets/assets/images/lechuga_0.webp": "2582bd0952e76b9bc5c2e61f3f27ceec",
"assets/assets/images/lechuga_1.webp": "3e81f3fb2caa6025806c3811bc07e121",
"assets/assets/images/cotiledones_1.webp": "a601c93e75f764d06e38e61bfb6d569f",
"assets/assets/images/tomate_1.webp": "2852ff5daaa327d04eba6b149514d675",
"assets/assets/images/receta_calabaza_con_tomates_y_brocoli.webp": "f558a7f23fb1a220715687a87b33d89a",
"assets/assets/images/brocoli_3.webp": "c56e102e260dbac4c8038616278ce257",
"assets/assets/images/tutorial_2.webp": "488a323052683b9caac776bb3eee6436",
"assets/assets/images/receta_gazpacho.webp": "13be7f6deea6a60ce3e7907264360467",
"assets/assets/images/tutorial_3.webp": "8911eb40d9cf18f02c0a92d519f34479",
"assets/assets/images/tomate_2.webp": "b33922793143c87c79ae1a68a7c2dbb5",
"assets/assets/images/zapallo_2.webp": "5d25af72432d6d403a87769f1dd049fb",
"assets/assets/images/icono_zanahoria.webp": "1b0b95f5b93e3b5fd3d28c137cdbcc80",
"assets/assets/images/papa_0.webp": "10dd4a84ae87879cb60bbb22ccba0761",
"assets/assets/images/receta_brocoli_con_pepino_y_zanahoria.webp": "923ba403b2f632f16c56d681f0e46a70",
"assets/assets/images/alcaucil_3.webp": "203afcc2b24f11f3698422b561652e6b",
"assets/assets/images/COCINA_cuadrado_rojo.webp": "05a182d74532746a25ea7e5123e6ca03",
"assets/assets/images/alcaucil_1.webp": "b8634aadd6a7b739aec1b68ad611418a",
"assets/assets/images/quinoa_1.webp": "7a694b07cc361ae64e9248f14288fe30",
"assets/assets/images/3_tierra_muerta.webp": "8b5e64a69965cb1b207521f13fcb7f0a",
"assets/assets/images/quinoa_2.webp": "93292bf355245369d0aa779184261b91",
"assets/assets/images/pepino_3.webp": "be950eceb5e3bf08e1abba249fa149ef",
"assets/assets/images/pepino_0.webp": "0005cad5cf05bf40ca2cf22e613593d3",
"assets/assets/images/alcaucil_2.webp": "0364d95a22a17334ed85da36360e4489",
"assets/assets/images/icono_recetas_1.webp": "991406f1250b3041d944e29c7a6f0bab",
"assets/assets/images/icono_moneda.webp": "11525c421c31f04dc0744ad083b53357",
"assets/assets/images/papa_1.webp": "b12b473035af55803c20439b1dbc6269",
"assets/assets/images/brocoli_1.webp": "6f50adffb3dc7f204a9c8ffc70bd85fb",
"assets/assets/images/brocoli_0.webp": "9495ec50d64e27c55268d56070ee7225",
"assets/assets/images/cebolla_0.webp": "c1ee086186f1dbf880aa7ec41cac1db9",
"assets/assets/images/quinoa_0.webp": "84d9a2e2a6cf832a63204ecae0bb342b",
"assets/assets/images/fumigador_512.webp": "66a981d5ce827023495820adf4e70921",
"assets/assets/images/tomate_0.webp": "663ef351d7370ac29b186a72b20bb8f6",
"assets/assets/images/pie_de_dialogo_5.webp": "fd93912400b10176dd9573e8ece307e6",
"assets/assets/images/COCINA_fondo.webp": "b2a66307c50b71f32da9de148721f28f",
"assets/assets/images/personaje_grande.webp": "430834abc3d937aa7d2098e3f150a245",
"assets/assets/images/brote_1_solo.webp": "eac3f1991816ccc209da81ad562802cb",
"assets/assets/images/estaciones_PRIMAVERA.webp": "29c5bf6eb998d647645d0f49ec0f7dc6",
"assets/assets/images/pepino_1.webp": "909f3e40801a2e317c9a2b3992dc704d",
"assets/assets/images/1080_game_over.webp": "2351acf0282a6fe9241f81ce398bab52",
"assets/assets/images/COCINA_flecha_roja.webp": "052aeae2ca1399853a5b3fce8353a32c",
"assets/assets/images/alcaucil_0.webp": "00430f0da20c49131e727c9852a1cb50",
"assets/assets/images/quinoa_3.webp": "34f4a9fe0f15c0bab2ea4bd269ca4b20",
"assets/assets/images/icono_quinoa.webp": "6184b621afe7341bc58d9234a4f10e00",
"assets/assets/images/cebolla_2.webp": "d4d48051fb7f1db6d3ccd05a0cb6b707",
"assets/assets/images/zapallo_0.webp": "7406a01a6487cf85f0ce0ce66238295d",
"assets/assets/images/1080_calavera.webp": "3783de41e1ecca117a40158341a90827",
"assets/assets/images/1080_fondo.webp": "983efbc0207114f546c7ee4e0920fece",
"assets/assets/images/parcela_infectada_2.webp": "bbb05c9af8748da74c2bebafaaa92af7",
"assets/assets/images/zanahoria_2.webp": "34a7cc4d3314f77fd587c28e4a8548be",
"assets/assets/images/icono_alcaucil.webp": "cb08bd0170120e47eba9d42ee3fe35e5",
"assets/assets/images/icono_maiz.webp": "9db62d2e27208b029bc72cecf3ea99ba",
"assets/assets/images/estaciones_OTONIO.webp": "340894fadf98e04fc6c6eb39f2e8b048",
"assets/assets/images/icono_zapallo.webp": "5e74b36a309447bcfec1be21a45fa26f",
"assets/assets/images/tomate_3.webp": "3b8bd8e5cf5bc353f059ab96914464fc",
"assets/assets/images/icono_papa.webp": "5ce5e89bb8346236dd2a860ff8989b88",
"assets/assets/images/icono_pepino.webp": "e71ecec671464c2b0d63e4e0127b6794",
"assets/assets/images/pie_de_dialogo_3.webp": "b8ff70c4a7a3619950cd1c36642c2a26",
"assets/assets/images/estaciones_VERANO.webp": "be87c261dbf1f36aeb192d0b5185e1bd",
"assets/assets/images/zanahoria_3.webp": "5d3408e57ada0643545da6abe66584f0",
"assets/assets/images/pie_de_dialogo_1.webp": "edc603ba9af220d2badcfab5611bf68d",
"assets/assets/fonts/Crayonara-Regular.ttf": "fb872c9fdc3d682b63282e3ad99a2e73",
"assets/assets/audio/heartbeat.mp3": "52db9c69fefe77865d63176f0e097d2c",
"assets/assets/audio/mistake.mp3": "732a82b3e291cb41d454993393095deb",
"assets/assets/audio/level_win.mp3": "03d4a962cbbd07fae87234c96546a394",
"assets/assets/audio/touch.wav": "878d556ff80c562c42daf2a395b6ee19",
"assets/assets/audio/seed-planting.mp3": "b91173839bfdb8a2ac64199e02bea3a8",
"assets/assets/audio/recipe_sold.wav": "1d803148735675d5349f1cc7c16890fc",
"assets/assets/audio/recipe_unlock.wav": "ffe82a18e981a1c06a0cfece8b4d9727",
"assets/assets/audio/espantapajaro.mp3": "d1cef14414957c2fb0ab13b20b5b83d9",
"assets/assets/audio/tango.mp3": "4604b6a65007048625c65e99d1e245f8",
"assets/assets/audio/music.mp3": "a041a9c530378af2569c901e917a5b0c",
"assets/assets/audio/item_purchase.wav": "3aca87f7eb228e380686739a3b26c595",
"assets/assets/audio/cooking.mp3": "7eac6a2ed72f35233393bc58ab55e03a",
"assets/assets/audio/sad-noise.wav": "7547c97558eae650ba3f402f2131366f",
"assets/assets/non_game_images/fondo_completo_sin_nubes.webp": "818e3d193e234a750369013979732fb1",
"assets/assets/non_game_images/nubes_panoramica.webp": "bb482388303a401b8d43bc770a24dee0",
"assets/assets/non_game_images/basura.webp": "c548bfe1db3244fa479f0d602c7dbdf2",
"assets/fonts/MaterialIcons-Regular.otf": "fe07a215c4fa07a222df368c7344ac37",
"assets/NOTICES": "a36cbcda7c92cd4ef5c665000c7fefb5",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/FontManifest.json": "bb010e71887df5ebe15353a88a44e757",
"assets/AssetManifest.bin": "b0a8b218ca72fe71be04e54b7117456d",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.wasm": "b0d681a27c6acfb535b98e36ab464006",
"flutter_bootstrap.js": "528b6d9f54e01979d0ca7debce7e05ef",
"version.json": "db9b455094bb834fa4b58fd29e7fc261",
"main.dart.js": "8d2c308dcaa5444adacac694f0655927"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
