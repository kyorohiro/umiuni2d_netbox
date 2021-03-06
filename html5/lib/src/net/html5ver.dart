part of hetima_mbaas_net_html5;

class TinyNetHtml5Builder extends TinyNetBuilder {
  Future<TinyNetRequester> createRequester() async {
    return new TinyNetHtml5HttpRequester();
  }
}

class TinyNetHtml5HttpRequester extends TinyNetRequester {
  Future<TinyNetRequesterResponse> request(String type, String url, {Object data:null, Map<String, String> headers: null}){
    if (headers == null) {
      headers = {};
    }
    Completer<TinyNetRequesterResponse> c = new Completer();
    try {
      html.HttpRequest req = new html.HttpRequest();
      req.responseType = "arraybuffer";
      req.open(type, url, async: true);
      for (String k in headers.keys) {
        req.setRequestHeader(k, headers[k]);
      }
      
      req.onReadyStateChange.listen((html.ProgressEvent e) {
        if (req.readyState == html.HttpRequest.DONE) {
          c.complete(new TinyNetRequesterResponse(req.status, req.responseHeaders, req.response));
        }
      });
      req.onError.listen((html.ProgressEvent e) {
        c.completeError(e);
      });
      if (data == null) {
        req.send();
      } else {
        req.send(data);
      }
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
