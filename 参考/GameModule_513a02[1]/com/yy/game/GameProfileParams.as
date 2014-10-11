package com.yy.game
{
    import flash.net.*;

    public class GameProfileParams extends Object
    {
        private var _fightPower:int = -1;
        private var _sex:String;
        private var _job:String;
        private var _partner:String;
        private var _equip:String;
        private var _iversion:String;
        private var _updateVersion:String;
        private var _runResource:String;
        private var _referrer:String;

        public function GameProfileParams(param1:Object = null)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1)
            {
                _loc_2 = {equip:"equip", fight_cap:"fightPower", ive:"iversion", job:"job", partner:"partner", ref:"referrer", rso:"runResource", sex:"sex", uve:"updateVersion"};
                for (_loc_3 in param1)
                {
                    
                    _loc_4 = _loc_2[_loc_3];
                    this[_loc_4] = _loc_6[_loc_3];
                }
            }
            return;
        }// end function

        public function get fightPower() : int
        {
            return this._fightPower;
        }// end function

        public function set fightPower(param1:int) : void
        {
            this._fightPower = param1;
            return;
        }// end function

        public function get sex() : String
        {
            return this._sex;
        }// end function

        public function set sex(param1:String) : void
        {
            if (param1 != Gender.MALE && param1 != Gender.FEMALE)
            {
                throw new ArgumentError("性别必须是Gender类的常量值");
            }
            this._sex = param1;
            return;
        }// end function

        public function get job() : String
        {
            return this._job;
        }// end function

        public function set job(param1:String) : void
        {
            if (param1 == null || param1.length <= 0)
            {
                throw new ArgumentError("job参数不能是null或空字符串");
            }
            this._job = param1;
            return;
        }// end function

        public function get partner() : String
        {
            return this._partner;
        }// end function

        public function set partner(param1:String) : void
        {
            if (param1 == null || param1.length <= 0)
            {
                throw new ArgumentError("partner参数不能是null或空字符串");
            }
            this._partner = param1;
            return;
        }// end function

        public function get equip() : String
        {
            return this._equip;
        }// end function

        public function set equip(param1:String) : void
        {
            if (param1 == null || param1.length <= 0)
            {
                throw new ArgumentError("equip参数不能是null或空字符串");
            }
            this._equip = param1;
            return;
        }// end function

        public function get iversion() : String
        {
            return this._iversion;
        }// end function

        public function set iversion(param1:String) : void
        {
            if (param1 == null || param1.length <= 0)
            {
                throw new ArgumentError("iversion参数不能是null或空字符串");
            }
            this._iversion = param1;
            return;
        }// end function

        public function get updateVersion() : String
        {
            if (this._updateVersion == null)
            {
                return this._iversion;
            }
            return this._updateVersion;
        }// end function

        public function set updateVersion(param1:String) : void
        {
            if (param1 == null || param1.length <= 0)
            {
                throw new ArgumentError("updateVersion参数不能是null或空字符串");
            }
            this._updateVersion = param1;
            return;
        }// end function

        public function get runResource() : String
        {
            return this._runResource;
        }// end function

        public function set runResource(param1:String) : void
        {
            if (param1 == null || param1.length <= 0)
            {
                throw new ArgumentError("runResource参数不能是null或空字符串");
            }
            this._runResource = param1;
            return;
        }// end function

        public function get referrer() : String
        {
            return this._referrer;
        }// end function

        public function set referrer(param1:String) : void
        {
            if (param1 == null || param1.length <= 0)
            {
                throw new ArgumentError("referrer参数不能是null或空字符串");
            }
            this._referrer = param1;
            return;
        }// end function

        function setVariable(param1:URLVariables) : void
        {
            if (this._iversion)
            {
                param1.ive = this._iversion;
            }
            if (this._updateVersion)
            {
                param1.uve = this._updateVersion;
            }
            if (this._runResource)
            {
                param1.rso = this._runResource;
            }
            if (this._referrer)
            {
                param1.ref = this._referrer;
            }
            return;
        }// end function

        private function getVal(param1:String, param2:Object) : String
        {
            if (param2.hasOwnProperty(param1))
            {
                return param2[param1];
            }
            return null;
        }// end function

    }
}
