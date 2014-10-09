package com.model.vo
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.game.newactivity.bean.*;
    import com.model.*;
    import com.staticdata.*;
    import com.util.*;

    public class NewActivityItemInfo extends Object
    {
        public var condiction:String;
        public var awardListStr:String;
        public var awardList:Array;
        public var jobAwardList:Array;
        public var canGet:int;
        public var index:int;
        public var activityId:int;
        public var condictionDes:String;

        public function NewActivityItemInfo()
        {
            return;
        }// end function

        public function conByActivityItemInfo(param1:ActivityItemInfo, param2:int, param3:int, param4:String) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = false;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            this.activityId = param3;
            this.index = param2;
            this.condictionDes = param4;
            this.condiction = param1.condiction;
            this.awardListStr = param1.awardList;
            this.canGet = param1.canGet;
            this.awardList = [];
            this.jobAwardList = [];
            if (param1.awardList && param1.awardList != "")
            {
                _loc_5 = param1.awardList.split(",");
                _loc_13 = UserObj.getInstance().playerInfo.job;
                _loc_15 = false;
                for each (_loc_6 in _loc_5)
                {
                    
                    _loc_7 = _loc_6.split("_");
                    _loc_9 = null;
                    var _loc_20:* = 0;
                    _loc_12 = 0;
                    _loc_11 = _loc_20;
                    if (_loc_7.length >= 6 && _loc_7[4].length > 0)
                    {
                        _loc_9 = [];
                        _loc_10 = _loc_7[5].split(";");
                        _loc_16 = 0;
                        while (_loc_16 < _loc_10.length)
                        {
                            
                            _loc_9[_loc_16] = new Object();
                            _loc_17 = (_loc_10[_loc_16] as String).split("|");
                            _loc_9[_loc_16].attributeType = _loc_17[0];
                            _loc_9[_loc_16].attributeValue = _loc_17[1];
                            _loc_16++;
                        }
                    }
                    if (_loc_7.length >= 3)
                    {
                        _loc_11 = _loc_7[3];
                    }
                    if (_loc_7.length >= 4)
                    {
                        _loc_12 = _loc_7[4];
                    }
                    _loc_14 = _loc_7[0];
                    if (_loc_14.charAt(0) == "!")
                    {
                        _loc_15 = true;
                        _loc_14 = _loc_14.replace("!", "");
                    }
                    else
                    {
                        _loc_15 = false;
                    }
                    _loc_8 = PropUtil.createItemByCfg(int(_loc_14), _loc_11, _loc_12, 0, _loc_9);
                    _loc_8.num = _loc_7[1];
                    _loc_8.isbind = _loc_15 ? (1) : (0);
                    this.awardList.push(_loc_8);
                    if (PropUtil.canUseByJob(_loc_7[2], _loc_13))
                    {
                        this.jobAwardList.push(_loc_8);
                    }
                }
            }
            return;
        }// end function

        public function getItemCondiction() : Array
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            if (this.condiction && this.condiction != "")
            {
                _loc_1 = [];
                _loc_9 = this.condiction.split("|");
                for each (_loc_2 in _loc_9)
                {
                    
                    _loc_4 = _loc_2.split("_");
                    _loc_5 = null;
                    var _loc_14:* = 0;
                    _loc_8 = 0;
                    _loc_7 = _loc_14;
                    if (_loc_4.length >= 5 && _loc_4[4].length > 0)
                    {
                        _loc_5 = [];
                        _loc_6 = _loc_4[4].split(",");
                        _loc_10 = 0;
                        while (_loc_10 < _loc_6.length)
                        {
                            
                            _loc_5[_loc_10] = new Object();
                            _loc_11 = (_loc_6[_loc_10] as String).split("|");
                            _loc_5[_loc_10].attributeType = _loc_11[0];
                            _loc_5[_loc_10].attributeValue = _loc_11[1];
                            _loc_10++;
                        }
                    }
                    if (_loc_4.length >= 3)
                    {
                        _loc_7 = _loc_4[2];
                    }
                    if (_loc_4.length >= 4)
                    {
                        _loc_8 = _loc_4[3];
                    }
                    _loc_3 = PropUtil.createItemByCfg(_loc_4[0], _loc_7, _loc_8, 0, _loc_5);
                    _loc_3.num = _loc_4[1];
                    _loc_1.push(_loc_3);
                }
            }
            return _loc_1;
        }// end function

        public function getStrCondiction() : Array
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this.condiction && this.condiction != "")
            {
                _loc_1 = this.condiction.split("|");
            }
            if (this.activityId == NewActivityConfig.ACTID_SEVEN_ACTIVITY_4 && _loc_1.length > 1)
            {
                _loc_2 = ZonesCloneCfg.getInstance().getZonesInfoFromId(int(_loc_1[1]));
                _loc_1[1] = _loc_2.duplicate_name;
            }
            return _loc_1;
        }// end function

    }
}
