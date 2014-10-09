package com.game.country.model
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.game.country.bean.*;
    import com.game.country.events.*;
    import com.game.utils.*;
    import com.model.*;

    public class CountryData extends BaseEventDispatcher
    {
        private var _countrystructureInfo:CountryStructureInfo;
        private var _countryTopInfolist:Vector.<CountryTopInfo>;
        private var _countryOverTopInfolist:Vector.<CountryTopInfo>;
        private var _countrywarinfo:CountryWarInfo;
        private var _jobAwardInfo:Vector.<JobAwardInfo>;
        private var _state:int;
        private var _curentCaptureID:long;
        private var _curPhase:int;
        private var _myCountryTopInfo:CountryTopInfo;
        private var _countryLeaderMemberInfo:CountryMemberInfo;
        private var _overExp:int;
        private var _overKill:int;
        private var _canGetAward:Boolean;
        private static var _instance:CountryData;

        public function CountryData()
        {
            return;
        }// end function

        public function get countrystructureInfo() : CountryStructureInfo
        {
            return this._countrystructureInfo;
        }// end function

        public function set countrystructureInfo(param1:CountryStructureInfo) : void
        {
            var _loc_4:* = null;
            this._countrystructureInfo = param1;
            var _loc_2:* = this._countrystructureInfo.countrymemberInfolist.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._countrystructureInfo.countrymemberInfolist[_loc_3];
                if (_loc_4.post == 1)
                {
                    this._countryLeaderMemberInfo = _loc_4;
                    break;
                }
                _loc_3++;
            }
            dispatchEvt(new CountryEvent(CountryEvent.COUNTRY_INFO_CHANGE, null));
            return;
        }// end function

        public function get countryTopInfolist() : Vector.<CountryTopInfo>
        {
            return this._countryTopInfolist;
        }// end function

        public function set countryTopInfolist(param1:Vector.<CountryTopInfo>) : void
        {
            this._countryTopInfolist = param1;
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                if (UserObj.getInstance().playerInfo.personId.equal(param1[_loc_2].playerid))
                {
                    this._myCountryTopInfo = param1[_loc_2];
                }
                _loc_2++;
            }
            dispatchEvt(new CountryEvent(CountryEvent.COUNTRY_TOP_INFO_CHANGE, null));
            return;
        }// end function

        public function get countryOverTopInfolist() : Vector.<CountryTopInfo>
        {
            return this._countryOverTopInfolist;
        }// end function

        public function set countryOverTopInfolist(param1:Vector.<CountryTopInfo>) : void
        {
            this._countryOverTopInfolist = param1;
            var _loc_2:* = 0;
            while (_loc_2 < this._countryOverTopInfolist.length)
            {
                
                if (UserObj.getInstance().playerInfo.personId.equal(this._countryOverTopInfolist[_loc_2].playerid))
                {
                    this._overExp = this._countryOverTopInfolist[_loc_2].exp;
                    this._overKill = this._countryOverTopInfolist[_loc_2].kill;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function get countrywarinfo() : CountryWarInfo
        {
            return this._countrywarinfo;
        }// end function

        public function set countrywarinfo(param1:CountryWarInfo) : void
        {
            this._countrywarinfo = param1;
            dispatchEvt(new CountryEvent(CountryEvent.COUNTRY_WAR_INFO_CHANGE, null));
            return;
        }// end function

        public function get curentCaptureID() : long
        {
            return this._curentCaptureID;
        }// end function

        public function set curentCaptureID(param1:long) : void
        {
            if (!param1.equal(new long(0, 0)))
            {
                this._curentCaptureID = param1;
                dispatchEvt(new CountryEvent(CountryEvent.COUNTRY_CAPTURE_CHANGE, null));
            }
            return;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function set state(param1:int) : void
        {
            this._state = param1;
            return;
        }// end function

        public function get jobAwardInfo() : Vector.<JobAwardInfo>
        {
            return this._jobAwardInfo;
        }// end function

        public function set jobAwardInfo(param1:Vector.<JobAwardInfo>) : void
        {
            this._jobAwardInfo = param1;
            return;
        }// end function

        public function get curPhase() : int
        {
            return this._curPhase;
        }// end function

        public function set curPhase(param1:int) : void
        {
            this._curPhase = param1;
            return;
        }// end function

        public function get myCountryTopInfo() : CountryTopInfo
        {
            return this._myCountryTopInfo;
        }// end function

        public function set myCountryTopInfo(param1:CountryTopInfo) : void
        {
            this._myCountryTopInfo = param1;
            return;
        }// end function

        public function get countryLeaderMemberInfo() : CountryMemberInfo
        {
            return this._countryLeaderMemberInfo;
        }// end function

        public function set countryLeaderMemberInfo(param1:CountryMemberInfo) : void
        {
            this._countryLeaderMemberInfo = param1;
            return;
        }// end function

        public function get overExp() : int
        {
            return this._overExp;
        }// end function

        public function set overExp(param1:int) : void
        {
            this._overExp = param1;
            return;
        }// end function

        public function get overKill() : int
        {
            return this._overKill;
        }// end function

        public function set overKill(param1:int) : void
        {
            this._overKill = param1;
            return;
        }// end function

        public function get canGetAward() : Boolean
        {
            return this._canGetAward;
        }// end function

        public function set canGetAward(param1:Boolean) : void
        {
            this._canGetAward = param1;
            return;
        }// end function

        public static function getInstance() : CountryData
        {
            if (_instance == null)
            {
                _instance = new CountryData;
            }
            return _instance;
        }// end function

        public static function getVirturalModelId(param1:int) : String
        {
            var _loc_2:* = null;
            var _loc_3:* = (param1 - 1) % 3 + 1;
            switch(_loc_3)
            {
                case 1:
                {
                    _loc_2 = "sm001";
                    break;
                }
                case 2:
                {
                    _loc_2 = "mg001";
                    break;
                }
                case 3:
                {
                    _loc_2 = "ac001";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
