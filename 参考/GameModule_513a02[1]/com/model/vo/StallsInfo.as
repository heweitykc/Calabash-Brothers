package com.model.vo
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.utils.*;
    import com.util.*;

    public class StallsInfo extends Object
    {
        private var _playername:String;
        private var _playerid:long;
        private var _stallslv:int;
        private var _stallsname:String;
        private var _index:int;
        private var _isNpc:int;
        private var _stallsgoodsinfo:Vector.<StallsGoodInfo>;

        public function StallsInfo()
        {
            this._stallsgoodsinfo = new Vector.<StallsGoodInfo>;
            return;
        }// end function

        public function get isNpc() : int
        {
            return this._isNpc;
        }// end function

        public function set isNpc(param1:int) : void
        {
            this._isNpc = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function get stallsgoodsinfo() : Vector.<StallsGoodInfo>
        {
            return this._stallsgoodsinfo;
        }// end function

        public function set stallsgoodsinfo(param1:Vector.<StallsGoodInfo>) : void
        {
            this._stallsgoodsinfo = param1;
            return;
        }// end function

        public function get stallsname() : String
        {
            return this._stallsname;
        }// end function

        public function set stallsname(param1:String) : void
        {
            this._stallsname = param1;
            return;
        }// end function

        public function get stallslv() : int
        {
            return this._stallslv;
        }// end function

        public function set stallslv(param1:int) : void
        {
            this._stallslv = param1;
            return;
        }// end function

        public function get playerid() : long
        {
            return this._playerid;
        }// end function

        public function set playerid(param1:long) : void
        {
            this._playerid = param1;
            return;
        }// end function

        public function get playername() : String
        {
            return this._playername;
        }// end function

        public function set playername(param1:String) : void
        {
            this._playername = param1;
            return;
        }// end function

        public function convGoods(param1:Vector.<StallsGoodsInfo>) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = new Vector.<StallsGoodInfo>;
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new StallsGoodInfo();
                if (param1[_loc_4].iteminfo.itemModelId == -1 || param1[_loc_4].iteminfo.itemModelId == -2)
                {
                    _loc_5.prop = new PropInfo();
                    _loc_5.prop.num = param1[_loc_4].iteminfo.num;
                    _loc_5.priceyuanbao = param1[_loc_4].priceyuanbao;
                    _loc_5.pricegold = param1[_loc_4].pricegold;
                    _loc_5.prop.itemId = param1[_loc_4].iteminfo.itemId;
                    _loc_5.prop.itemModelId = param1[_loc_4].iteminfo.itemModelId;
                    if (param1[_loc_4].iteminfo.itemModelId == -1)
                    {
                        _loc_5.prop.q_name = LanguageCfgObj.getInstance().getByIndex("10039");
                    }
                    else if (param1[_loc_4].iteminfo.itemModelId == -2)
                    {
                        _loc_5.prop.q_name = LanguageCfgObj.getInstance().getByIndex("10040");
                    }
                }
                else
                {
                    _loc_6 = ItemCfgObj.getInstance().getCfgBy(param1[_loc_4].iteminfo.itemModelId);
                    if (PropUtil.isEquip(_loc_6.q_type))
                    {
                        _loc_5.prop = new EquipmentInfo();
                        (_loc_5.prop as EquipmentInfo).conv(param1[_loc_4].iteminfo);
                        _loc_5.pricegold = param1[_loc_4].pricegold;
                        _loc_5.priceyuanbao = param1[_loc_4].priceyuanbao;
                    }
                    else
                    {
                        _loc_5.prop = new PropInfo();
                        _loc_5.prop.conv(param1[_loc_4].iteminfo);
                        _loc_5.pricegold = param1[_loc_4].pricegold;
                        _loc_5.priceyuanbao = param1[_loc_4].priceyuanbao;
                    }
                }
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            this.stallsgoodsinfo = _loc_2;
            return;
        }// end function

    }
}
