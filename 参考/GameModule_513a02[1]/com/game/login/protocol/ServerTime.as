package com.game.login.protocol
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.login.message.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.utils.*;

    public class ServerTime extends BaseProtocol
    {
        private var _nowBeatCnt:int;
        private var lastTime:Number;
        private var noLegal:int;
        private var legalFlag:Boolean = true;
        private var startTime:uint;
        private var _preBeatTime:Number;
        private var beatInt:uint;
        private var pingTime:int;
        public var ping:uint;
        private var pingTimeoutTimes:int = 0;
        private var fps:Number = 0;
        private var fpsn:int = 0;
        private var tweenLite:TweenLite;
        public static const INTERVAL:int = 60000;
        public static const QUERY_GIFT_INTERVAL:int = 60;
        private static var instance:ServerTime;
        private static var fpsSprite:Sprite;
        private static var closeShowing:Boolean = false;
        public static var pingMap:Dictionary = new Dictionary();

        public function ServerTime()
        {
            return;
        }// end function

        public function start() : void
        {
            if (this._nowBeatCnt == 0)
            {
                this.startTime = getTimer();
                clearInterval(this.beatInt);
                this.beatInt = setInterval(this.__beat, INTERVAL);
                this.__beat();
            }
            return;
        }// end function

        public function forceBeat() : void
        {
            Log.log("force send beat.");
            var _loc_1:* = this;
            var _loc_2:* = this._nowBeatCnt - 1;
            _loc_1._nowBeatCnt = _loc_2;
            this.__beat();
            return;
        }// end function

        private function __beat() : void
        {
            Log.log("心跳请求");
            var _loc_2:* = this;
            var _loc_3:* = this._nowBeatCnt + 1;
            _loc_2._nowBeatCnt = _loc_3;
            if (QUERY_GIFT_INTERVAL == this._nowBeatCnt)
            {
                this._nowBeatCnt = 0;
            }
            this.pingTime = getTimer();
            var _loc_1:* = new ReqHeartMessage();
            _loc_1.time = this.pingTime - this.startTime;
            send(_loc_1);
            return;
        }// end function

        public function heartBeatHandler(param1:ResHeartMessage) : void
        {
            this.ping = getTimer() - this.pingTime;
            Log.log("心跳返回,ping=" + this.ping, param1.time, param1.time2);
            var _loc_2:* = param1.time;
            this.pingTimeoutTimes = 0;
            this.setNewTime(_loc_2 * 1000);
            this.checkAddBuff(_loc_2 * 1000);
            this._preBeatTime = _loc_2 * 1000;
            return;
        }// end function

        override protected function timeout(param1:uint, param2:uint) : void
        {
            this.__error();
            return;
        }// end function

        override protected function fault(param1:uint, param2:uint, param3) : void
        {
            this.__error();
            return;
        }// end function

        private function __error() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this.pingTimeoutTimes + 1;
            _loc_1.pingTimeoutTimes = _loc_2;
            if (this.pingTimeoutTimes >= 3)
            {
                socketClosed();
            }
            return;
        }// end function

        public function setNewTime(param1:Number) : void
        {
            var _loc_2:* = new Date().time;
            ToolKit.timeOffset = param1 + this.ping / 2 - _loc_2;
            Log.log("本地时间" + ToolKit.getLogDate(_loc_2) + ",服务器时间" + ToolKit.getLogDate(param1) + ",差值=" + (param1 + this.ping / 2 - _loc_2) + "ms,ping=" + this.ping + "ms,fps=" + int(this.fps));
            this.checkMem();
            return;
        }// end function

        private function isLegal(param1:Number) : void
        {
            if (INTERVAL > Math.abs(param1 + this.ping - this.lastTime) * 1.2)
            {
                var _loc_2:* = this;
                var _loc_3:* = this.noLegal + 1;
                _loc_2.noLegal = _loc_3;
                if (this.noLegal > 1)
                {
                    this.legalFlag = false;
                    socketClosed();
                }
            }
            else
            {
                this.noLegal = 0;
                this.legalFlag = true;
            }
            return;
        }// end function

        public function updateFtg(param1:uint) : void
        {
            if (this.tweenLite != null)
            {
                TweenLite.killDelayedCallsTo(this.doUpdateFtg);
                this.tweenLite = null;
            }
            if (param1 == 0)
            {
                this.doUpdateFtg();
            }
            else
            {
                this.tweenLite = TweenLite.delayedCall(param1, this.doUpdateFtg);
            }
            return;
        }// end function

        private function doUpdateFtg() : void
        {
            return;
        }// end function

        public function loadPings(param1:Vector.<String>) : void
        {
            return;
        }// end function

        private function checkMem() : void
        {
            return;
        }// end function

        private function checkAddBuff(param1:Number) : void
        {
            var _loc_2:* = new Date();
            if (this._preBeatTime > 0)
            {
                _loc_2.setTime(this._preBeatTime);
            }
            var _loc_3:* = new Date();
            _loc_3.setTime(param1);
            if (_loc_2.hours == 11 && _loc_3.hours == 12 || _loc_2.hours == 17 && _loc_3.hours == 18)
            {
                Log.log("12点或18点，查询体力");
            }
            if (_loc_2.hours == 23 && _loc_3.hours == 0)
            {
            }
            return;
        }// end function

        public static function getInstance() : ServerTime
        {
            if (instance == null)
            {
                instance = new ServerTime;
            }
            return instance;
        }// end function

        private static function socketClosed() : void
        {
            if (!closeShowing)
            {
                closeShowing = true;
                BasicGlobal.usePopManager(function () : void
            {
                BasicGlobal.popManager.cue(ToolKit.getLogDate() + LanguageCfgObj.getInstance().getByLoginIndex("1018"), "", null, function () : void
                {
                    JSTools.reload();
                    return;
                }// end function
                );
                return;
            }// end function
            );
            }
            return;
        }// end function

    }
}
