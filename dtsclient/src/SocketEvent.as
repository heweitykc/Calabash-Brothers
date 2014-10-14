package
{
    import flash.events.*;

    public class SocketEvent extends Event
    {
        public var obj:Object;
        public static const CONNECTED:String = "onConnected";
        public static const CLOSED:String = "onClosed";
        public static const ERROR:String = "onError";
        public static const RECEIVE_DATA:String = "onReceiveData";

        public function SocketEvent(param1:String, param2 = null)
        {
            super(param1);
            this.obj = param2;
            return;
        }// end function

        override public function clone() : Event
        {
            return new SocketEvent(type, this.obj);
        }// end function

    }
}
