module {
  public type HttpRequest = {
    body: Blob;
    headers: [HeaderField];
    method: Text;
    url: Text;
  };
  public type HttpResponse = {
    body: Blob;
    headers: [HeaderField];
    status_code: Nat16;
  };
  type HeaderField = (Text, Text);
};