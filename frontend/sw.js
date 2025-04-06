
self.addEventListener('install', function(event) {
  event.waitUntil(caches.open('aarogya-cache').then(function(cache) {
    return cache.addAll(['/index.html']);
  }));
});
