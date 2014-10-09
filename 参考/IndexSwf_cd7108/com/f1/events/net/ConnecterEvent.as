package com.f1.events.net
{
    import com.f1.net.*;
    import flash.events.*;

    public class ConnecterEvent extends Event
    {
        public var cmd:int;
        public var sn:uint;
        public var result:uint;
        public var socketHandler:SocketHandler;
        public var obj:Object;
        public static const CONNECT_FAIL:String = "connect_fail";
        public static const CONNECT:String = "connect";
        public static const AUTHED:String = "authed";
        public static const RESPONSE:String = "delegate_response";

        public function ConnecterEvent(param1:String, param2:int = 0, param3:uint = 0, param4:uint = 0, param5:SocketHandler = null, param6 = null)
        {
            super(param1);
            this.cmd = param2;
            this.sn = param3;
            this.result = param4;
            this.socketHandler = param5;
            this.obj = param6;
            return;
        }// end function

        override public function clone() : Event
        {
            return new ConnecterEvent(type, this.cmd, this.sn, this.result, this.obj);
        }// end function

    }
}
