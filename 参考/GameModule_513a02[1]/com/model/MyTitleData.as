package com.model
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.utils.*;

    public class MyTitleData extends BaseEventDispatcher
    {
        private var _topTitleId:int;
        private var _titleMap:Dictionary;
        private var _titleVect1:Array;
        private var _titleVect2:Array;
        private var _titleVect3:Array;
        public static const BASE_ID:int = 10000;
        private static var _instance:MyTitleData;

        public function MyTitleData()
        {
            this._titleMap = new Dictionary();
            this._titleVect1 = this.createTitleByRange(BASE_ID * 1, BASE_ID * 2);
            this._titleVect2 = this.createTitleByRange(BASE_ID * 2, BASE_ID * 3);
            this._titleVect3 = this.createTitleByRange(BASE_ID * 3, BASE_ID * 4);
            return;
        }// end function

        private function createTitleByRange(param1:int, param2:int) : Array
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = [];
            var _loc_4:* = TitleCfgObj.getInstance().MapDic;
            var _loc_5:* = UserObj.getInstance().playerInfo.job;
            for each (_loc_6 in _loc_4)
            {
                
                if (_loc_6.q_rank >= param1 && _loc_6.q_rank < param2 && (_loc_6.q_show_job == 0 || _loc_6.q_show_job > 0 && JobType.matchJob(_loc_5, _loc_6.q_show_job)))
                {
                    _loc_7 = new TitleVO();
                    _loc_7.titleid = _loc_6.q_titleid;
                    _loc_7.rankQ = _loc_6.q_rank;
                    _loc_3.push(_loc_7);
                    this._titleMap[_loc_7.titleid] = _loc_7;
                }
            }
            _loc_3 = _loc_3.sort(this.sortHandler);
            return _loc_3;
        }// end function

        public function initMyTitles(param1:Array, param2:Array) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1[_loc_4];
                _loc_6 = this._titleMap[_loc_5];
                if (_loc_6)
                {
                    _loc_6.openTitle(param2[_loc_4]);
                }
                else
                {
                    _loc_6 = this.addRestTitle(_loc_5, 0);
                    _loc_6.openTitle(param2[_loc_4]);
                }
                _loc_4++;
            }
            dispatchEvt(new Event(Event.CHANGE));
            return;
        }// end function

        private function addRestTitle(param1:int, param2:int) : TitleVO
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_3:* = TitleCfgObj.getInstance().getTitleById(param1);
            if (_loc_3)
            {
                _loc_5 = _loc_3.q_rank / BASE_ID;
                if (_loc_5 == 1)
                {
                    _loc_4 = this._titleVect1;
                }
                else if (_loc_5 == 2)
                {
                    _loc_4 = this._titleVect2;
                }
                else
                {
                    _loc_4 = this._titleVect3;
                }
                _loc_6 = new TitleVO();
                _loc_6.titleid = _loc_3.q_titleid;
                _loc_6.rankQ = _loc_3.q_rank;
                this._titleMap[_loc_6.titleid] = _loc_6;
                _loc_4.push(_loc_6);
            }
            return _loc_6;
        }// end function

        public function resetTitles() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._titleMap)
            {
                
                if (_loc_1)
                {
                    _loc_1.reset();
                }
            }
            return;
        }// end function

        public function updateTitle(param1:int, param2:int) : void
        {
            var _loc_3:* = this._titleMap[param1];
            if (_loc_3)
            {
                _loc_3.openTitle(param2);
            }
            else
            {
                _loc_3 = this.addRestTitle(param1, param2);
                if (_loc_3)
                {
                    _loc_3.openTitle(param2);
                }
            }
            return;
        }// end function

        private function sortHandler(param1:TitleVO, param2:TitleVO) : int
        {
            var _loc_3:* = param1.rankQ - param2.rankQ;
            return _loc_3;
        }// end function

        public function get topTitleId() : int
        {
            return this._topTitleId;
        }// end function

        public function set topTitleId(param1:int) : void
        {
            var _loc_2:* = null;
            if (this._topTitleId != param1)
            {
                _loc_2 = this._titleMap[this._topTitleId];
                if (_loc_2)
                {
                    _loc_2.isUsing = false;
                }
                this._topTitleId = param1;
                _loc_2 = this._titleMap[this._topTitleId];
                if (_loc_2)
                {
                    _loc_2.isUsing = true;
                }
            }
            return;
        }// end function

        public function getTitleVect1(param1:Boolean) : Array
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (param1)
            {
                _loc_2 = [];
                _loc_3 = this._titleVect1.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_5 = this._titleVect1[_loc_4];
                    if (_loc_5.isGot)
                    {
                        _loc_2.push(_loc_5);
                    }
                    _loc_4++;
                }
                return _loc_2;
            }
            return this._titleVect1;
        }// end function

        public function getTitleVect2(param1:Boolean) : Array
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (param1)
            {
                _loc_2 = [];
                _loc_3 = this._titleVect2.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_5 = this._titleVect2[_loc_4];
                    if (_loc_5.isGot)
                    {
                        _loc_2.push(_loc_5);
                    }
                    _loc_4++;
                }
                return _loc_2;
            }
            return this._titleVect2;
        }// end function

        public function getTitleVect3(param1:Boolean) : Array
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (param1)
            {
                _loc_2 = [];
                _loc_3 = this._titleVect3.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_5 = this._titleVect3[_loc_4];
                    if (_loc_5.isGot)
                    {
                        _loc_2.push(_loc_5);
                    }
                    _loc_4++;
                }
                return _loc_2;
            }
            return this._titleVect3;
        }// end function

        public static function get instance() : MyTitleData
        {
            if (_instance == null)
            {
                _instance = new MyTitleData;
            }
            return _instance;
        }// end function

        public static function getTabIndex(param1:int) : int
        {
            var _loc_2:* = TitleCfgObj.getInstance().getTitleById(param1);
            var _loc_3:* = 0;
            if (_loc_2)
            {
                _loc_3 = _loc_2.q_rank / BASE_ID - 1;
            }
            return _loc_3;
        }// end function

    }
}
