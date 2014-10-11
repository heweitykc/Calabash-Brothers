package com.f1
{
    import __AS3__.vec.*;
    import com.f1.events.net.*;
    import com.f1.interfaces.*;
    import com.f1.net.*;
    import com.f1.utils.*;
    import flash.utils.*;

    public class BaseProto extends BaseEventDispatcher implements IBaseProtocol
    {
        protected var cmdList:Vector.<String>;
        protected var sendLocked:Vector.<uint>;
        public static const RESULT:int = 0;
        public static const FAULT:int = 1;
        public static const TIMEOUT:int = -1;
        private static var prefix:String = "CMD_";
        private static var err1:String = "Error:mainConnecter为空，请设置FrameworkGlobal.mainConnecter";
        private static var TIMEOUT_INT:int = 10000;
        private static var SN:uint = 0;
        private static var snCallbakMap:HashMap = new HashMap();

        public function BaseProto()
        {
            this.cmdList = new Vector.<String>;
            this.sendLocked = new Vector.<uint>;
            return;
        }// end function

        protected function sendPkg(param1:uint, param2, param3:Boolean = false, param4:Function = null, param5:Boolean = false, param6:Boolean = false) : void
        {
            var _loc_7:* = 0;
            if (this.ifLocked(param1))
            {
                Log.log(param1, "操作被锁！");
                return;
            }
            if (param1 != 0)
            {
                this.addCmdsListener(param1);
                if (FrameworkGlobal.mainConnecter != null)
                {
                    SN = 0;
                    _loc_7 = FrameworkGlobal.mainConnecter.send(param2, SN, param6);
                    if (_loc_7 == 0)
                    {
                        this.addSNCallback(param1, SN, param4);
                        if (param5)
                        {
                            this.addSNCallback(param1, 0, param4);
                        }
                    }
                    else
                    {
                        Log.log(param1, " 发送协议出错 iRet=", _loc_7);
                    }
                    if (param3)
                    {
                        this.lock(param1);
                    }
                }
                else
                {
                    Log.log(err1);
                }
            }
            else
            {
                Log.log("请指定操作");
            }
            return;
        }// end function

        protected function __responder(event:ConnecterEvent) : void
        {
            var _loc_2:* = event.sn;
            var _loc_3:* = event.cmd;
            if (event.result == 0)
            {
                this.result(_loc_3, event.obj);
                this.snCallbackResult(_loc_3, _loc_2, event.obj);
            }
            else
            {
                this.fault(_loc_3, event.result, event.obj);
                this.snCallbackFault(_loc_3, _loc_2, event.result, event.obj);
            }
            return;
        }// end function

        protected function addCmdsListener(... args) : void
        {
            var _loc_3:* = null;
            args = FrameworkGlobal.mainConnecter;
            if (args != null)
            {
                for each (_loc_3 in args)
                {
                    
                    if (this.cmdList.indexOf(_loc_3) == -1)
                    {
                        if (_loc_5.hasEventListener(prefix + _loc_3))
                        {
                            Log.log("注意有其他类也监听了", prefix + _loc_3);
                        }
                        this.cmdList.push(_loc_3);
                        _loc_5.addEvtListener(prefix + _loc_3, this.__responder);
                    }
                }
            }
            else
            {
                Log.log(err1);
            }
            return;
        }// end function

        protected function removeCmdListener(param1:uint) : void
        {
            var _loc_2:* = this.cmdList.indexOf(param1);
            if (_loc_2 != -1)
            {
                this.cmdList.splice(_loc_2, 1);
            }
            FrameworkGlobal.mainConnecter.removeEvtListener(prefix + param1, this.__responder);
            return;
        }// end function

        public function removeAllCmdListener() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = FrameworkGlobal.mainConnecter;
            for each (_loc_2 in this.cmdList)
            {
                
                _loc_1.removeEvtListener(prefix + _loc_2, this.__responder);
            }
            return;
        }// end function

        protected function result(param1:uint, param2) : void
        {
            return;
        }// end function

        protected function fault(param1:uint, param2:uint, param3) : void
        {
            return;
        }// end function

        protected function timeout(param1:uint, param2:uint) : void
        {
            return;
        }// end function

        private function __timeout(param1:uint, param2:uint) : void
        {
            this.snCallbackTimeout(param1, param2);
            this.timeout(param1, param2);
            return;
        }// end function

        protected function lock(param1:uint) : void
        {
            if (this.sendLocked.indexOf(param1) == -1)
            {
                this.sendLocked.push(param1);
            }
            return;
        }// end function

        protected function unlock(param1:uint) : void
        {
            var _loc_2:* = this.sendLocked.indexOf(param1);
            if (_loc_2 != -1)
            {
                this.sendLocked.splice(_loc_2, 1);
            }
            return;
        }// end function

        protected function ifLocked(param1:uint) : Boolean
        {
            if (this.sendLocked.indexOf(param1) == -1)
            {
                return false;
            }
            return true;
        }// end function

        public function finalize() : void
        {
            this.removeAllCmdListener();
            return;
        }// end function

        protected function sendPkgAndBack(param1:uint, param2, param3:Function = null, param4:Boolean = false, param5:Boolean = false) : void
        {
            if (param5)
            {
                this.sendPkg(param1, param2, param5, param3);
            }
            else
            {
                this.sendPkg(param1, param2, false, param3, param4);
            }
            return;
        }// end function

        private function snCallbackTimeout(param1:uint, param2:uint) : void
        {
            var _loc_3:* = this.popSNCallback(param1, param2);
            if (_loc_3 != null)
            {
                this._loc_3(TIMEOUT, 0, null);
            }
            return;
        }// end function

        private function snCallbackResult(param1:uint, param2:uint, param3) : void
        {
            var _loc_4:* = this.popSNCallback(param1, param2);
            if (this.popSNCallback(param1, param2) != null)
            {
                this._loc_4(RESULT, 0, param3);
            }
            return;
        }// end function

        private function snCallbackFault(param1:uint, param2:uint, param3:uint, param4) : void
        {
            var _loc_5:* = this.popSNCallback(param1, param2);
            if (this.popSNCallback(param1, param2) != null)
            {
                this._loc_5(FAULT, param3, param4);
            }
            return;
        }// end function

        private function addSNCallback(param1:uint, param2:uint, param3:Function) : void
        {
            var _loc_4:* = 0;
            this.popSNCallback(param1, param2);
            if (param3 != null)
            {
                _loc_4 = setTimeout(this.__timeout, TIMEOUT_INT, param1, param2);
                snCallbakMap.put(param1 + "_" + param2, [_loc_4, getTimer(), param3]);
            }
            return;
        }// end function

        private function popSNCallback(param1:uint, param2:uint) : Function
        {
            var _loc_3:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_4:* = snCallbakMap.remove(param1 + "_" + param2);
            if (snCallbakMap.remove(param1 + "_" + param2) && _loc_4.length == 3)
            {
                _loc_5 = _loc_4[0];
                _loc_6 = _loc_4[1];
                _loc_3 = _loc_4[2];
                if (_loc_5 > 0)
                {
                    clearTimeout(_loc_5);
                }
                _loc_7 = getTimer();
                _loc_8 = _loc_7 - _loc_6;
                this.addPing(param1, _loc_8);
            }
            return _loc_3;
        }// end function

        private function addPing(param1:uint, param2:int) : void
        {
            var _loc_3:* = Pings.pingMap[param1];
            if (_loc_3)
            {
                _loc_3.push(param2);
            }
            else
            {
                _loc_3 = [param2];
                Pings.pingMap[param1] = _loc_3;
            }
            return;
        }// end function

    }
}
