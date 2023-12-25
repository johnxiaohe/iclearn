import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Int "mo:base/Int";
import Array "mo:base/Array";
import Qsort "quickSort";
import Fib "fib";
import Htm "httpmodule"

actor {

  // first charpter
  public query func fibonacci(n : Nat) :async Text{
    return "fib(" # Nat.toText(n) # ") =" # Nat.toText(Fib.fib(n))
  };

  // second charpter
  /* quick sort by double point */
  public query func qsort(arr: [Int]): async [Int]{
    let size = Array.size(arr);
    if (size == 0){
      return [];
    };
    let varArr = Array.thaw<Int>(arr);
    Qsort.quickSort(varArr, 0, size-1);
    return Array.freeze<Int>(varArr);
  };

  // three charpter
    // memory var
  stable var count : Nat = 0;

  public query func http_request(arg : Htm.HttpRequest): async Htm.HttpResponse {
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
  
};
