package com.f1.net
{
    import com.f1.*;
    import com.f1.events.net.*;
    import com.f1.utils.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class SocketHandler extends BaseEventDispatcher
    {
        protected var unSeq:uint;
        protected var m_socket:Socket;
        protected var receiveBuf:ByteArray;
        protected var msgBuf:ByteArray;
        protected var pos:uint;
        protected var msgLen:uint;
        protected var recvHead:Boolean = true;
        private var svrIP:String;
        private var svrPort:uint = 0;
        private var svrSPort:uint = 0;
        private var isAuthed:Boolean = false;
        private var appID:uint = 0;
        private var _linkMode:uint = 1;
        private var sendMsgArray:Array;
        private var linkStatus:uint = 0;
        private var _receiveFun:Function;
        public static const KEEP_LIVE_TIME:uint = 600;
        public static const CONSTANT_LINK:uint = 1;
        public static const INSTANT_LINK:uint = 2;
        public static const SEMI_CONSTANT_LINK:uint = 3;
        static const LINK_STATUS_NOTINITIALIZED:uint = 0;
        static const LINK_STATUS_NOTAVAILABLE:int = 1;
        static const LINK_STATUS_NEEDTOCONNECT:uint = 2;
        static const LINK_STATUS_CONNECTTING:uint = 3;
        static const LINK_STATUS_CONNECTED:uint = 4;

        public function SocketHandler()
        {
            this.receiveBuf = new ByteArray();
            this.msgBuf = new ByteArray();
            this.sendMsgArray = [];
            this.m_socket = null;
            return;
        }// end function

        public function get linkMode() : uint
        {
            return this._linkMode;
        }// end function

        public function close() : void
        {
            this.m_socket.removeEventListener(ProgressEvent.SOCKET_DATA, this.onReceiveData);
            this.m_socket.close();
            return;
        }// end function

        public function getSocketHandler() : BaseEventDispatcher
        {
            return this;
        }// end function

        public function setAddr(param1:uint, param2:String, param3:int, param4:int = 0, param5:uint = 1) : void
        {
            this.svrIP = param2;
            this.svrPort = param3;
            this.svrSPort = param4;
            this.appID = param1;
            this._linkMode = param5;
            return;
        }// end function

        public function connect() : void
        {
            if (this.svrIP == null)
            {
                throw "null svr ip address!!";
            }
            if (this.linkStatus == LINK_STATUS_CONNECTED)
            {
                Log.log("it\'s connected ...");
                return;
            }
            Log.log("connect", this.svrIP, this.svrPort, this.svrSPort);
            if (this.m_socket != null)
            {
                this.m_socket.removeEventListener(Event.CONNECT, this.onConnected);
                this.m_socket.removeEventListener(Event.CLOSE, this.onClosed);
                this.m_socket.removeEventListener(ProgressEvent.SOCKET_DATA, this.onReceiveData);
                this.m_socket.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
                this.m_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
                this.m_socket = null;
            }
            this.m_socket = new Socket();
            this.m_socket.addEventListener(Event.CONNECT, this.onConnected);
            this.m_socket.addEventListener(Event.CLOSE, this.onClosed);
            this.m_socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onReceiveData);
            this.m_socket.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this.m_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
            if (this.svrSPort > 0)
            {
                Log.log("策略文件IP和端口： " + this.svrIP + ":" + this.svrSPort.toString());
                Security.loadPolicyFile("xmlsocket://" + this.svrIP + ":" + this.svrSPort.toString());
            }
            Log.log("连接服务器 " + this.svrIP + ":" + this.svrPort);
            this.m_socket.connect(this.svrIP, this.svrPort);
            return;
        }// end function

        public function get connected() : Boolean
        {
            return this.m_socket != null && this.m_socket.connected;
        }// end function

        public function get app() : uint
        {
            return this.appID;
        }// end function

        public function get authed() : Boolean
        {
            return this.isAuthed;
        }// end function

        public function get ipAddr() : String
        {
            return this.svrIP;
        }// end function

        public function get port() : uint
        {
            return this.svrPort;
        }// end function

        public function get sport() : uint
        {
            return this.svrSPort;
        }// end function

        public function setAuthed() : void
        {
            this.isAuthed = true;
            return;
        }// end function

        public function disconnect() : Boolean
        {
            if (this.m_socket != null)
            {
                this.m_socket.removeEventListener(Event.CONNECT, this.onConnected);
                this.m_socket.removeEventListener(Event.CLOSE, this.onClosed);
                this.m_socket.removeEventListener(ProgressEvent.SOCKET_DATA, this.onReceiveData);
                this.m_socket.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
                this.m_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
                this.m_socket.close();
                return true;
            }
            return false;
        }// end function

        public function sendPackage(param1:ByteArray) : Boolean
        {
            if (!param1 || param1.length <= 0)
            {
                Log.log("conent is null!");
                return false;
            }
            if (this.m_socket != null && this.m_socket.connected)
            {
                param1.position = 0;
                this.m_socket.writeBytes(param1);
                this.m_socket.flush();
                return true;
            }
            if (this.linkMode == CONSTANT_LINK)
            {
                Log.log("长连接没有连接成功呢，发啥消息啊");
                return false;
            }
            Log.log("sendMsgArray.push(content)");
            this.sendMsgArray.push(param1);
            if (this.linkStatus == LINK_STATUS_CONNECTTING)
            {
                return true;
            }
            return false;
        }// end function

        public function onConnected(event:Event) : void
        {
            Log.log("套接字已连接上", this.svrIP, this.svrPort, this.svrSPort);
            this.linkStatus = LINK_STATUS_CONNECTED;
            dispatchEvent(new SocketEvent(SocketEvent.CONNECTED));
            return;
        }// end function

        public function addReceiveHandler(param1:Function) : void
        {
            this._receiveFun = param1;
            return;
        }// end function

        public function onClosed(event:Event) : void
        {
            Log.log("套接字断开", this.svrIP, this.svrPort, this.svrSPort);
            if (this.m_socket != null)
            {
                this.m_socket.close();
            }
            this.linkStatus = LINK_STATUS_NEEDTOCONNECT;
            dispatchEvent(new SocketEvent(SocketEvent.CLOSED));
            return;
        }// end function

        public function onError(event:ErrorEvent) : void
        {
            dispatchEvent(new SocketEvent(SocketEvent.ERROR, event));
            return;
        }// end function

        protected function onReceiveData(event:ProgressEvent) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            if (this.m_socket.bytesAvailable <= 0)
            {
                return;
            }
            this.m_socket.readBytes(this.receiveBuf, this.receiveBuf.length);
            this.receiveBuf.position = 0;
            var _loc_2:* = false;
            while (true)
            {
                
                if (this.receiveBuf.bytesAvailable <= 4)
                {
                    break;
                }
                this.msgLen = this.receiveBuf.readInt();
                if ((this.msgLen & 16777216) != 0)
                {
                    _loc_2 = true;
                    this.msgLen = this.msgLen & 16777215;
                }
                else
                {
                    _loc_2 = false;
                }
                if (this.receiveBuf.bytesAvailable >= this.msgLen && this.msgLen > 0)
                {
                    _loc_4 = this.receiveBuf.readInt();
                    this.msgBuf.length = 0;
                    this.receiveBuf.readBytes(this.msgBuf, 0, this.msgLen - 4);
                    if (_loc_2)
                    {
                        this.msgBuf.uncompress();
                    }
                    if (this._receiveFun != null)
                    {
                        this._receiveFun.call(null, _loc_4, this.msgBuf);
                    }
                    continue;
                }
                this.receiveBuf.position = this.receiveBuf.position - 4;
                break;
            }
            var _loc_3:* = this.receiveBuf.bytesAvailable;
            if (_loc_3 > 0)
            {
                _loc_5 = this.receiveBuf.position;
                _loc_6 = new ByteArray();
                _loc_6.position = 0;
                _loc_6.writeBytes(this.receiveBuf, _loc_5, _loc_3);
                this.receiveBuf = _loc_6;
            }
            this.receiveBuf.length = _loc_3;
            return;
        }// end function

        protected function getNextSequenceID() : uint
        {
            var _loc_1:* = this;
            var _loc_2:* = this.unSeq + 1;
            _loc_1.unSeq = _loc_2;
            return this.unSeq;
        }// end function

    }
}
