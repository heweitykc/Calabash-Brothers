package com.manager.cd
{
    import com.events.*;
    import com.f1.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.utils.*;

    public class CDManager extends Object
    {
        private var skillCDTime:Number;
        private var skillCDbeginTime:Number;
        private var _isInSkillPublicCD:Boolean;
        private var _CDDic:Dictionary;
        private static var instance:CDManager;

        public function CDManager()
        {
            this._CDDic = new Dictionary();
            return;
        }// end function

        public function addCD(param1:String, param2:uint, param3:uint, param4:uint = 0, param5:int = -1, param6:int = -1) : void
        {
            this.doAddCD(param1 + "_" + param4, param2, param3);
            if (param5 != -1)
            {
                param5 = param5 - (UserObj.getInstance().playerInfo.attackspeed - 100) * 10;
                param5 = param5 > Params.PUBLIC_CD_MIN ? (param5) : (Params.PUBLIC_CD_MIN);
                this.doAddCD(param1 + "_" + CDTypes.PUBLIC + "_" + param6, param5, param5);
            }
            FrameworkGlobal.sendMsg(new GameEvent(GameEvent.CD_CHANGE));
            if (param1 == CDTypes.SKILL)
            {
                this._isInSkillPublicCD = true;
                this.skillCDTime = param5;
                this.skillCDbeginTime = getTimer();
                FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.skillPublicCDFinish);
            }
            return;
        }// end function

        private function doAddCD(param1:String, param2:uint, param3:uint) : void
        {
            var _loc_4:* = this._CDDic[param1];
            if (!this._CDDic[param1])
            {
                _loc_4 = new CDInfo();
                this._CDDic[param1] = _loc_4;
            }
            _loc_4.update(param2, param3);
            return;
        }// end function

        public function isInCD(param1:String, param2:uint = 0, param3:int = -1) : Boolean
        {
            return this.getCD(param1, param2, param3)[0] > 0;
        }// end function

        public function isInSkillPublicCD() : Boolean
        {
            return this._isInSkillPublicCD;
        }// end function

        private function skillPublicCDFinish(event:Event) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this.skillCDbeginTime >= this.skillCDTime)
            {
                this._isInSkillPublicCD = false;
                FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.skillPublicCDFinish);
                FrameworkGlobal.sendMsg(new GameEvent(GameEvent.SKILL_PUBLIC_CD_CHANGE));
            }
            return;
        }// end function

        public function getCD(param1:String, param2:uint = 0, param3:int = -1) : Array
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (param3 != -1)
            {
                _loc_7 = param1 + "_" + CDTypes.PUBLIC + "_" + param3;
                _loc_6 = this._CDDic[_loc_7];
                if (_loc_6)
                {
                    _loc_4 = _loc_6.remainTime;
                    _loc_5 = _loc_6.delay;
                }
            }
            _loc_7 = param1 + "_" + param2;
            _loc_6 = this._CDDic[_loc_7];
            if (_loc_6)
            {
                _loc_8 = _loc_6.remainTime;
                _loc_9 = _loc_6.delay;
            }
            if (_loc_4 > _loc_8)
            {
                return [_loc_4, _loc_5];
            }
            return [_loc_8, _loc_9];
        }// end function

        public static function getInstance() : CDManager
        {
            if (instance == null)
            {
                instance = new CDManager;
            }
            return instance;
        }// end function

    }
}
