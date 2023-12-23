import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Int "mo:base/Int";
import Array "mo:base/Array";
actor {

  // memory var
  stable var count : Nat = 0;

  // first charpter
  func fib(n : Nat) : Nat{
      if(n <= 1){
        1
      }else{
        fib(n-1) + fib(n-2)
      }
  };

  public query func fibonacci(n : Nat) :async Text{
    return "fib(" # Nat.toText(n) # ") =" # Nat.toText(fib(n))
  };

  // second charpter
  /* quick sort by double point */
  public query func qsort(arr: [Int]): async [Int]{
    let size = Array.size(arr);
    if (size == 0){
      return [];
    };
    let varArr = Array.thaw<Int>(arr);
    quickSort(varArr, 0, size-1);
    return Array.freeze<Int>(varArr);
  };

  func quickSort(arr: [var Int], low: Nat, high: Nat){
    if (low < high){
      let index = partition(arr, low, high);
      quickSort(arr, low, index);
      quickSort(arr, index+1, high);
    }
  };
  func partition(arr: [var Int], low: Nat, high: Nat): Nat{
    let pivot = arr[low];
    var left = low;
    var right = high;
    while(left < right){
      while(left < right and arr[right] >= pivot){
        right := right - 1;
      };
      arr[left] := arr[right];
      while(left < right and arr[left] < pivot){
        left := left + 1;
      };
      arr[right] := arr[left];
    };
    arr[left] := pivot;
    return left;
  };

  // three charpter
  type HttpRequest = {
    body: Blob;
    headers: [HeaderField];
    method: Text;
    url: Text;
  };
  type HttpResponse = {
    body: Blob;
    headers: [HeaderField];
    status_code: Nat16;
  };
  type HeaderField = (Text, Text);
  public query func http_request(arg : HttpRequest): async HttpResponse {
      return {
        body = Text.encodeUtf8(Nat.toText(count));
        headers = [];
        status_code = 200;
      };
  };
  public func increment() : async (){
    count+=1;
  };
  public query func get() : async Nat{
    return count;
  };

  public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };
};
