package com.game.map.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.map.control.*;
    import com.game.map.view.viewItem.*;
    import com.model.*;
    import com.model.vo.*;
    import com.view.tipcell.*;
    import flash.events.*;
    import flash.text.*;

    public class BigMapWorldView extends Component
    {
        private var _mapList:Vector.<BaseButton>;
        private var _txtList:Vector.<TextField>;
        private const WORLD_MAP_LIST:Array;

        public function BigMapWorldView(param1 = null, param2:String = null)
        {
            this.WORLD_MAP_LIST = [100002, 100014, 100015, 100013, 100006, 100001, 100003, 100018, 100016, 100024, 100017, 100020, 100019, 100022, 8];
            super(param1, param2);
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_8:* = null;
            this._mapList = new Vector.<BaseButton>;
            this._txtList = new Vector.<TextField>;
            var _loc_1:* = 0;
            var _loc_2:* = this.WORLD_MAP_LIST.length;
            var _loc_7:* = UserObj.getInstance().playerInfo.level;
            while (_loc_1 < _loc_2)
            {
                
                _loc_3 = new BaseButton(getDisplayChildByName("map_" + this.WORLD_MAP_LIST[_loc_1]));
                _loc_6 = MapCfgObj.getInstance().getWorldMap(this.WORLD_MAP_LIST[_loc_1]);
                _loc_3.obj = _loc_6;
                this._mapList.push(_loc_3);
                _loc_3.addEventListener(MouseEvent.CLICK, this._clickWorldMap);
                ItemTips.create(_loc_3, _loc_6, WorldMapTips);
                _loc_4 = getDisplayChildByName("txt_" + this.WORLD_MAP_LIST[_loc_1]);
                this._txtList.push(_loc_4);
                _loc_8 = new WorldMapItem();
                _loc_8.setBtn(_loc_3);
                _loc_8.setText(_loc_4);
                _loc_8.setObj(_loc_6);
                _loc_1++;
            }
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.UPDATE_LEVEL, this.__resetMapText);
            return;
        }// end function

        private function __resetMapText(event:RoleEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = this.WORLD_MAP_LIST.length;
            var _loc_7:* = UserObj.getInstance().playerInfo.level;
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = MapCfgObj.getInstance().getWorldMap(this.WORLD_MAP_LIST[_loc_2]);
                _loc_5 = this._txtList[_loc_2];
                if (_loc_4)
                {
                    _loc_6 = _loc_4.mapWorldName + "\n";
                    if (_loc_4.recMaxLv != 0)
                    {
                        if (_loc_7 >= _loc_4.recMinLv && _loc_7 <= _loc_4.recMaxLv)
                        {
                            _loc_6 = _loc_6 + ("<font color=\'#ffeab7\'>Lv." + _loc_4.recMinLv + "-" + _loc_4.recMaxLv + "</font>");
                        }
                        else
                        {
                            _loc_6 = _loc_6 + ("<font color=\'#807059\'>Lv." + _loc_4.recMinLv + "-" + _loc_4.recMaxLv + "</font>");
                        }
                    }
                    _loc_5.htmlText = _loc_6;
                }
                else
                {
                    _loc_5.text = "";
                }
                _loc_2++;
            }
            return;
        }// end function

        private function _clickWorldMap(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget.obj as WorldMapInfo;
            if (_loc_2)
            {
                MapControl.getInstance().goldMapTrans(_loc_2.mapId);
            }
            else
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10939"));
            }
            return;
        }// end function

    }
}
