// import Array "mo:base/Array";

/* quick sort by double point */
module{
    public func quickSort(arr: [var Int], low: Nat, high: Nat){
        if (low < high){
            let index = partition(arr, low, high);
            quickSort(arr, low, index);
            quickSort(arr, index+1, high);
        }
    };
    public func partition(arr: [var Int], low: Nat, high: Nat): Nat{
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
}

