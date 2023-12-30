import Principal "mo:base/Principal";
import Time "mo:base/Time";
import List "mo:base/List";
import Iter "mo:base/Iter";
import Text "mo:base/Text";

actor MicroBlog{

    public type MicroBlog = actor{
        follow: shared(Principal) -> async ();
        follows: shared query () -> async [Principal];
        post: shared(Text) -> async();
        posts: shared query(Time.Time) -> async[Message];
        timeline: shared (Time.Time) -> async[Message];
    };

    public type Message = {
        content: Text;
        ctime: Time.Time;
    };
    stable var followed : List.List<Principal> = List.nil();
    stable var msgs : List.List<Message> = List.nil();

    // follow other 
    public shared({caller}) func follow(canisterId : Principal) : async (){
        followed := List.push(canisterId, followed);
    };
    // follow list
    public shared({caller}) func follows() : async [Principal] {
        List.toArray(followed);
    };

    // post new msg
    public shared({caller}) func post(text: Text): async (){
        let message: Message = {
            content =  text;
            ctime = Time.now();
        };
        msgs := List.push(message, msgs);
    };

    // get all post after since time 
    public shared({caller}) func posts(since : Time.Time): async [Message]{
        var result: List.List<Message> = List.nil();
        for (message in Iter.fromList(msgs)){
            if(since <= message.ctime){
                result := List.push(message, result);
            }
        };
        List.toArray(result);
    };

    // get all followed posts after since time
    public shared({caller}) func timeline(since: Time.Time): async [Message]{
        var all : List.List<Message> = List.nil();
        for (id in Iter.fromList(followed)){
            let microblog: MicroBlog = actor(Principal.toText(id));
            let followedMsgs =  await microblog.posts(since);
            for (msg in Iter.fromArray(followedMsgs)){
                all := List.push(msg, all);
            }
        };
        List.toArray(all);
    };
}