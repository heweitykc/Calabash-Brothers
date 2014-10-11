package com.f1.interfaces
{
    import com.f1.interfaces.*;
    import com.f1.net.*;

    public interface IConnecter extends IBaseEventDispatcher
    {

        public function IConnecter();

        function send(param1, param2:uint, param3:Boolean = false) : int;

        function close() : void;

        function isLive() : Boolean;

        function isPlayerSvrLive() : Boolean;

        function connect() : void;

        function addConnection(param1:String, param2:uint, param3:uint, param4:uint) : SocketHandler;

        function isSocketLive(param1:uint) : Boolean;

    }
}
