package com.game.challenge.view.component
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.backpack.control.*;
    import com.game.backpack.view.*;
    import com.game.challenge.bean.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.tipcell.*;
    import com.view.ui.list.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class DropEventItem extends ListItem
    {
        private var _contentTxt:TextField;
        private var _upIcon:DisplayObject;
        private var dropInfo:Object;
        private var tip:BaseTips;

        public function DropEventItem(param1:String = "bossGuide_dropEvent", param2:String = "back")
        {
            super(param1, param2);
            return;
        }// end function

        override protected function getComp() : void
        {
            this._contentTxt = _content.getChildByName("contentTxt") as TextField;
            _content.addEventListener(TextEvent.LINK, this.__click);
            this._contentTxt.addEventListener(MouseEvent.MOUSE_OUT, this.__moveout);
            return;
        }// end function

        override protected function receive() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            this.dropInfo = obj;
            var _loc_1:* = "";
            if (this.dropInfo is BossEventInfo)
            {
                _loc_3 = this.dropInfo;
                _loc_4 = MonsterCfgObj.getInstance().getMonsterCfg(_loc_3.bossId);
                _loc_1 = _loc_1 + (ToolKit.getFormatDate(_loc_3.time.toNumber(), "YMDhms") + "   ");
                _loc_2 = PropUtil.getEquipNameAndColor(PropUtil.createItemByItemInfo(_loc_3.itemInfo));
                _loc_1 = _loc_1 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11957"), ["<font color=\'#13a400\'><a href=\'event:playName\'><u>" + _loc_3.playerName + "</u></a></font>", "<font color=\'#13a400\'><a href=\'event:where\'>" + MapCfgObj.getInstance().getMap(_loc_3.bossMapId).mapName + "</u></font>", "<font color=\'#d20404\'><a href=\'event:boss\'>" + _loc_4.q_name + "[" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11901"), [_loc_4.q_grade]) + "]</a></font>", "<font color=\'#" + (_loc_2[1] as int).toString(16) + "\'><a href=\'event:dropItem\'><u>[" + ItemCfgObj.getInstance().getItemCfg(_loc_3.itemInfo.itemModelId).q_name + "]</u></a></font>"]);
                this._contentTxt.htmlText = _loc_1;
                this.setUpIcon(_loc_3.type == 2);
            }
            else if (this.dropInfo is PandoraEventInfo)
            {
                _loc_5 = this.dropInfo;
                _loc_1 = _loc_1 + (ToolKit.getFormatDate(_loc_5.time.toNumber(), "YMDhms") + "   ");
                _loc_6 = PropUtil.createItemByItemInfo(_loc_5.pandoraInfo);
                _loc_2 = PropUtil.getEquipNameAndColor(_loc_6);
                _loc_7 = PropUtil.createItemByItemInfo(_loc_5.itemInfo);
                _loc_8 = PropUtil.getEquipNameAndColor(_loc_7);
                _loc_1 = _loc_1 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11958"), ["<font color=\'#13a400\'><a href=\'event:playName\'><u>" + _loc_5.playerName + "</u></a></font>", "<font color=\'#" + (_loc_2[1] as int).toString(16) + "\'><a href=\'event:cashBox\'><u>[" + _loc_6.q_name + "]</u></a></font>", "<font color=\'#" + (_loc_8[1] as int).toString(16) + "\'><a href=\'event:dropItem\'><u>[" + _loc_7.q_name + "]</u></a></font>"]);
                this._contentTxt.htmlText = _loc_1;
                this.setUpIcon(_loc_5.type == 4);
            }
            return;
        }// end function

        private function __click(event:TextEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            switch(event.text)
            {
                case "playName":
                {
                    _loc_2 = new RoleInfo();
                    _loc_2.personId = this.dropInfo.playerId;
                    _loc_2.name = this.dropInfo.playerName;
                    ItemPopMenu.instance.show(null, FrameworkGlobal.stage, 0, 0, ItemPopMenu.GUILD, _loc_2);
                    break;
                }
                case "where":
                {
                    break;
                }
                case "boss":
                {
                    break;
                }
                case "dropItem":
                {
                    _loc_3 = PropUtil.createItemByItemInfo(this.dropInfo.itemInfo);
                    this.tip = EquipCompareControl.createEquipTips(_loc_3);
                    break;
                }
                case "cashBox":
                {
                    _loc_4 = PropUtil.createItemByItemInfo(this.dropInfo.pandoraInfo);
                    this.tip = EquipCompareControl.createEquipTips(_loc_4);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __moveout(event:MouseEvent) : void
        {
            if (this.tip)
            {
                if (this.tip.parent)
                {
                    this.tip.parent.removeChild(this.tip);
                }
                this.tip = null;
            }
            return;
        }// end function

        private function setUpIcon(param1:Boolean = true) : void
        {
            if (!this._upIcon && param1)
            {
                this._upIcon = ToolKit.getNewDO("bossGuide_up");
                this._upIcon.x = 676;
            }
            if (param1)
            {
                addChild(this._upIcon);
            }
            else if (this._upIcon && this._upIcon.parent)
            {
                removeChild(this._upIcon);
            }
            return;
        }// end function

        override public function finalize() : void
        {
            if (this.tip && this.tip.parent)
            {
                this.tip.parent.removeChild(this.tip);
                this.tip.finalize();
            }
            this._contentTxt.removeEventListener(MouseEvent.MOUSE_OUT, this.__moveout);
            super.finalize();
            return;
        }// end function

    }
}
