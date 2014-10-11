package com.connect
{
    import com.*;
    import com.f1.*;
    import com.f1.events.net.*;
    import com.f1.interfaces.*;
    import com.f1.net.*;
    import com.f1.ui.box.*;
    import com.f1.utils.*;
    import com.net.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.utils.*;
    import net.*;

    public class Connecter extends BaseSprite implements IConnecter
    {
        private var socketHandlerMap:Dictionary;
        private var prefix:String = "CMD_";
        private var SERVER_PREFIX:String = "ServerID_";
        private var timeoutInt:int;
        private var connectionCnt:int = 0;
        private var _ignoreCmdsBeforeEnterMap:Array;

        public function Connecter()
        {
            this._ignoreCmdsBeforeEnterMap = [118101];
            BasicGlobal.messagePool = new RegistMessagePool();
            this.socketHandlerMap = new Dictionary();
            return;
        }// end function

        public function addConnection(param1:String, param2:uint, param3:uint, param4:uint) : SocketHandler
        {
            var _loc_5:* = new SocketHandler();
            _loc_5.setAddr(param4, param1, param2, param3);
            _loc_5.addEvtListener(SocketEvent.CONNECTED, this.__onConnect);
            _loc_5.addReceiveHandler(this.receiveData);
            _loc_5.addEvtListener(SocketEvent.CLOSED, this.__onClose);
            _loc_5.addEvtListener(SocketEvent.ERROR, this.__onError);
            this.socketHandlerMap[this.SERVER_PREFIX + param4] = _loc_5;
            var _loc_6:* = this;
            var _loc_7:* = this.connectionCnt + 1;
            _loc_6.connectionCnt = _loc_7;
            return _loc_5;
        }// end function

        public function connect() : void
        {
            var _loc_1:* = null;
            if (this.connectionCnt == 0)
            {
                throw "No connection is available!!";
            }
            for (_loc_1 in this.socketHandlerMap)
            {
                
                if (!_loc_3[_loc_1].connected)
                {
                    _loc_3[_loc_1].connect();
                    this.timeoutInt = setTimeout(this.__timeOut, 15000, _loc_3[_loc_1]);
                    Log.log("Connecter::connect,setTimeOut," + _loc_1 + _loc_3[_loc_1]);
                }
            }
            return;
        }// end function

        private function __timeOut(param1:SocketHandler) : void
        {
            this.showMsg(LanguageCfgObj.getInstance().getByIndex("10189"));
            return;
        }// end function

        private function __onConnect(event:SocketEvent) : void
        {
            clearTimeout(this.timeoutInt);
            Log.log("连接服务器成功: " + (event.currentTarget as SocketHandler).ipAddr + ":" + (event.currentTarget as SocketHandler).port + ":" + (event.currentTarget as SocketHandler).sport);
            dispatchEvent(new ConnecterEvent(ConnecterEvent.CONNECT, 0, 0, 0, event.currentTarget as SocketHandler));
            return;
        }// end function

        private function __onClose(event:SocketEvent) : void
        {
            if (!FrameworkGlobal.substituted)
            {
                this.showMsg(LanguageCfgObj.getInstance().getByIndex("10191"));
            }
            dispatchEvent(event);
            return;
        }// end function

        private function __onError(event:SocketEvent) : void
        {
            Log.log("连接主服务器失败", event.obj);
            dispatchEvent(event);
            return;
        }// end function

        private function showMsg(param1:String) : void
        {
            var str:* = param1;
            BasicGlobal.usePopManager(function () : void
            {
                var _loc_1:* = SysCueBox(BasicGlobal.popManager.cue(str, "", null, reConnect, null, 1, LanguageCfgObj.getInstance().getByLoginIndex("1017"), false, false, null, false));
                _loc_1.yesClose = false;
                return;
            }// end function
            );
            return;
        }// end function

        private function reConnect() : void
        {
            JSTools.reload();
            return;
        }// end function

        private function receiveData(param1:int, param2:ByteArray) : void
        {
            if (!Params.hasEnterMap)
            {
                if (param1 > 101000 && param1 < 101200 && param1 != 101120 || this._ignoreCmdsBeforeEnterMap.indexOf(param1) != -1)
                {
                    return;
                }
            }
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = BasicGlobal.messagePool.getMessage(param1);
            if (!BasicGlobal.messagePool.getMessage(param1))
            {
                return;
            }
            _loc_5.read(param2);
            Log.log("<==收cmd：", param1, getQualifiedClassName(_loc_5).split("::")[1]);
            var _loc_6:* = BasicGlobal.messagePool.getHandler(param1);
            _loc_6.setMessage(_loc_5);
            _loc_6.action();
            return;
        }// end function

        public function send(param1, param2:uint, param3:Boolean = false) : int
        {
            var _loc_7:* = null;
            if (!param1)
            {
                return 0;
            }
            var _loc_4:* = Message(param1);
            _loc_4.write();
            var _loc_5:* = new ByteArray();
            _loc_5.writeInt(0);
            _loc_5.writeInt(_loc_4.getId());
            if (param3)
            {
                _loc_7 = Satify.write(_loc_4.getBuf());
                _loc_5.writeBytes(_loc_7);
            }
            else
            {
                _loc_5.writeBytes(_loc_4.getBuf());
            }
            _loc_5.position = 0;
            ByteArrayUtil.directWriteInt(_loc_5, 0, _loc_5.length - 4);
            var _loc_6:* = this.socketHandlerMap[this.SERVER_PREFIX + ServerID.MAINSVR];
            if (this.socketHandlerMap[this.SERVER_PREFIX + ServerID.MAINSVR] == null)
            {
                throw "No socket handler is found for app " + this.SERVER_PREFIX + ServerID.MAINSVR;
            }
            _loc_6.sendPackage(_loc_5);
            Log.log("发=====>长度:" + (_loc_5.length - 4) + " cmd:", _loc_4.getId(), getQualifiedClassName(_loc_4).split("::")[1]);
            _loc_4.clear();
            return 0;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function isLive() : Boolean
        {
            var _loc_1:* = null;
            if (this.connectionCnt == 0)
            {
                return false;
            }
            for (_loc_1 in this.socketHandlerMap)
            {
                
                if (_loc_1 && !_loc_3[_loc_1].connected)
                {
                    return false;
                }
            }
            return true;
        }// end function

        public function isPlayerSvrLive() : Boolean
        {
            return true;
        }// end function

        public function isSocketLive(param1:uint) : Boolean
        {
            if (this.socketHandlerMap[this.SERVER_PREFIX + param1])
            {
                return this.socketHandlerMap[this.SERVER_PREFIX + param1].connected;
            }
            return false;
        }// end function

        private function callZloading(param1:String, param2:String) : void
        {
            if (FrameworkGlobal.connectCallBack != null)
            {
                FrameworkGlobal.connectCallBack(param1, param2);
            }
            return;
        }// end function

    }
}
