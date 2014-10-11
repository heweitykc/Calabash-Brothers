package com.game.expireguide.control
{
    import com.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.backpack.model.*;
    import com.game.equip.message.*;
    import com.game.expireguide.protocol.*;
    import com.game.expireguide.view.*;
    import com.game.player.model.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import com.util.*;

    public class ExpireGuideControl extends Object
    {
        private var _itemList:Array;
        private var _protocol:ExpireGuideProtocol;
        private var box:ExpireBox;
        private var view:ExpireView;
        private static var _instance:ExpireGuideControl;

        public function ExpireGuideControl()
        {
            this._itemList = [];
            this._protocol = new ExpireGuideProtocol();
            return;
        }// end function

        public function checkBackpack() : void
        {
            var _loc_1:* = BackpackObj.getInstance().info;
            var _loc_2:* = 0;
            var _loc_3:* = _loc_1.items.length;
            while (_loc_2 < _loc_3)
            {
                
                if (_loc_1.items[_loc_2] && PropUtil.checkItemExpire(_loc_1.items[_loc_2]) && _loc_1.items[_loc_2].q_kind == 11)
                {
                    this.addToList(_loc_1.items[_loc_2]);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function expireHandler(param1:ResEquipTimeLostMessage) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = EquipsObj.getInstance().info;
            if (_loc_3 && _loc_3.items)
            {
                _loc_4 = _loc_3.items.length;
                while (_loc_2 < _loc_4)
                {
                    
                    if (_loc_3.items[_loc_2] && _loc_3.items[_loc_2].itemId && _loc_3.items[_loc_2].itemId.equal(param1.equipId) && this.checkType(_loc_3.items[_loc_2]))
                    {
                        this.addToList(_loc_3.items[_loc_2]);
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        private function addToList(param1:PropInfo) : void
        {
            this._itemList.push(param1);
            if (this._itemList.length == 1)
            {
                this.addIcon(param1);
            }
            return;
        }// end function

        private function addIcon(param1:PropInfo) : void
        {
            var _loc_2:* = new ExpireServerIcon("expireServerIcon");
            _loc_2.info = param1;
            _loc_2.count = 1;
            Global.popManager.addedServerToCue(_loc_2);
            return;
        }// end function

        public function showByEquipInfo(param1:EquipmentInfo) : void
        {
            var _loc_2:* = this._itemList.indexOf(param1);
            if (_loc_2 != -1)
            {
                this._itemList.splice(_loc_2, 1);
                if (this._itemList.length)
                {
                    this.addIcon(this._itemList.shift());
                }
            }
            if (param1.q_kind == 12)
            {
                this.showType12(param1);
            }
            else if (param1.q_kind == 11)
            {
                this.showType11(param1);
            }
            return;
        }// end function

        private function showType12(param1:EquipmentInfo) : void
        {
            if (!this.box)
            {
                this.box = new ExpireBox("new_sys_cue_box1");
                Global.popManager.addPop(this.box, true, false, true, true, false, true);
            }
            var _loc_2:* = PropUtil.getEquipNameAndColor(param1);
            this.box.cue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12043"), [_loc_2[0], _loc_2[0]]), LanguageCfgObj.getInstance().getByIndex("11635"), null, this.showViewByEquipInfo, null, 1, LanguageCfgObj.getInstance().getByIndex("10004"));
            this.box.setInfo(param1);
            this.box.open();
            return;
        }// end function

        private function showType11(param1:EquipmentInfo) : void
        {
            if (!this.view)
            {
                this.view = new ExpireView();
                Global.popManager.addPop(this.view);
            }
            this.view.setInfo(param1);
            this.view.open();
            return;
        }// end function

        private function showViewByEquipInfo() : void
        {
            this.box.close();
            return;
        }// end function

        private function checkType(param1:PropInfo) : Boolean
        {
            if (param1.q_kind == 11 || param1.q_kind == 12)
            {
                return true;
            }
            return false;
        }// end function

        public function reqRenewProtect(param1:long) : void
        {
            this._protocol.renewProtect(param1);
            return;
        }// end function

        public function resRenewProtectResult(param1:ResRenewProtectMessage) : void
        {
            if (param1.result == 1)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10681"));
                this.view.close();
            }
            else if (param1.result == 0)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10682"));
            }
            return;
        }// end function

        public static function getInstance() : ExpireGuideControl
        {
            var _loc_1:* = new ExpireGuideControl;
            _instance = new ExpireGuideControl;
            return _instance || _loc_1;
        }// end function

    }
}
