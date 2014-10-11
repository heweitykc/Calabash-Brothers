package com.model
{
    import __AS3__.vec.*;
    import com.f1.utils.path.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class NpcList extends Object
    {
        private var _npcs:Dictionary;
        private static var _instance:NpcList;

        public function NpcList()
        {
            return;
        }// end function

        public function get npcs() : Dictionary
        {
            return this._npcs;
        }// end function

        public function reset() : void
        {
            this._npcs = new Dictionary();
            return;
        }// end function

        public function addNpc(param1:INpc) : void
        {
            this._npcs[param1.info.personId.toString()] = param1;
            return;
        }// end function

        public function removeNpc(param1:INpc) : void
        {
            this._npcs[param1.info.personId.toString()] = null;
            delete this._npcs[param1.info.personId.toString()];
            return;
        }// end function

        public function getNpc(param1:long) : INpc
        {
            return this._npcs[param1.toString()];
        }// end function

        public function getNpcByCfgId(param1:uint) : INpc
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in this._npcs)
            {
                
                if (_loc_2 && _loc_2.info)
                {
                    _loc_3 = _loc_2.info as NpcShowInfo;
                    if (_loc_3 && _loc_3.cfgId == param1)
                    {
                        return _loc_2;
                    }
                }
            }
            return null;
        }// end function

        public function getNearestNpcByCfgId(param1:Vector.<int>) : INpc
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_5:* = RoleList.getInstance().player;
            for each (_loc_6 in this._npcs)
            {
                
                if (_loc_6 && _loc_6.info)
                {
                    _loc_7 = _loc_6.info as NpcShowInfo;
                    if (_loc_7 && param1.indexOf(_loc_7.cfgId) != -1)
                    {
                        _loc_3 = MapUtils.countDistance([_loc_5.px, _loc_5.py], [MapUtils.coo2Tile(_loc_6._x), MapUtils.coo2Tile(_loc_6._y)]);
                        if (_loc_3 < _loc_2 || _loc_2 == 0)
                        {
                            _loc_2 = _loc_3;
                            _loc_4 = _loc_6;
                        }
                    }
                }
            }
            return _loc_4;
        }// end function

        public static function getInstance() : NpcList
        {
            if (_instance == null)
            {
                _instance = new NpcList;
            }
            return _instance;
        }// end function

    }
}
