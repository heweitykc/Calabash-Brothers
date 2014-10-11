package com.game.autopk.controller
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.autopk.*;
    import com.game.autopk.event.*;
    import com.game.autopk.model.*;
    import com.game.autopk.protocol.*;
    import com.game.autopk.view.*;
    import com.game.clickstream.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.player.control.*;
    import com.game.role.*;
    import com.game.task.*;
    import com.game.task.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.events.*;
    import interfaces.role.*;

    public class AutoFightController extends Object
    {
        private var _isAutoFighting:Boolean = false;
        public var arriveCoordVo:TaskCoordVO;
        public var drink:DrinkLogic;
        private var _fightPanel:AutoFightPanel;
        private var _vipPanel:VipSetPanel;
        private var _sellPanel:AutoFightSellSetPanel;
        private var _skillPanel:AutoFightSkillSetPanel;
        private var _autoFightIcon:AutoFightIcon;
        private var _autoGatherIcon:AutoFightIcon;
        private var _autoFindIcon:AutoFightIcon;
        private var target:AutoFightIcon;
        private static var instance:AutoFightController;

        public function AutoFightController()
        {
            return;
        }// end function

        public function setArriveCoordVo(param1:int, param2:int, param3:int, param4:int) : void
        {
            this.arriveCoordVo = new TaskCoordVO();
            this.arriveCoordVo.id = param4;
            this.arriveCoordVo.mapId = param1;
            this.arriveCoordVo.x = param2;
            this.arriveCoordVo.y = param3;
            return;
        }// end function

        public function start() : void
        {
            if (!this.drink)
            {
                AutoFightProtocol.getInstance().reqGetAssistantMessage();
                this.drink = new DrinkLogic();
                this.drink.autoDrink(true);
            }
            return;
        }// end function

        public function get fightPanel() : AutoFightPanel
        {
            return this._fightPanel;
        }// end function

        public function openFightPanel() : void
        {
            if (this.fightPanel == null)
            {
                this._fightPanel = new AutoFightPanel();
                Global.popManager.addPop(this.fightPanel);
            }
            this._fightPanel.open();
            AutoFightProtocol.getInstance().reqGetAssistantMessage();
            return;
        }// end function

        public function openOrCloseFightPanel() : void
        {
            if (MapObj.getInstance().mapID != Params.COUNTRY_MAP_ID)
            {
                if (this.fightPanel)
                {
                    this.fightPanel.openOrClose();
                }
                else
                {
                    this.openFightPanel();
                }
                if (this.fightPanel.isOpen)
                {
                    ClickStream.add(ClickStreamId.OPEN_ZhanDouZhuShou);
                }
            }
            else
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10300"));
            }
            return;
        }// end function

        public function doSaveAutoFightConfig() : void
        {
            if (this._fightPanel)
            {
                this._fightPanel.getTableData();
                AutoFightModel.save();
            }
            return;
        }// end function

        public function get vipPanel() : VipSetPanel
        {
            return this._vipPanel;
        }// end function

        public function openVipSetPanel() : void
        {
            if (this.vipPanel == null)
            {
                this._vipPanel = new VipSetPanel();
                Global.popManager.addPop(this._vipPanel);
            }
            this._vipPanel.open();
            return;
        }// end function

        public function openOrCloseVipSetPanel() : void
        {
            if (this.vipPanel)
            {
                this.vipPanel.openOrClose();
            }
            else
            {
                this.openVipSetPanel();
            }
            return;
        }// end function

        public function get sellPanel() : AutoFightSellSetPanel
        {
            return this._sellPanel;
        }// end function

        public function openSellSetPanel() : void
        {
            if (this._sellPanel == null)
            {
                this._sellPanel = new AutoFightSellSetPanel();
                Global.popManager.addPop(this._sellPanel);
            }
            this._sellPanel.open();
            return;
        }// end function

        public function openOrCloseSellSetPanel() : void
        {
            if (this.sellPanel)
            {
                this.sellPanel.openOrClose();
            }
            else
            {
                this.openSellSetPanel();
            }
            return;
        }// end function

        public function get skillPanel() : AutoFightSkillSetPanel
        {
            return this._skillPanel;
        }// end function

        public function openSkillSetPanel() : void
        {
            if (this._skillPanel == null)
            {
                this._skillPanel = new AutoFightSkillSetPanel();
                Global.popManager.addPop(this._skillPanel);
            }
            this._skillPanel.open();
            return;
        }// end function

        public function openOrCloseSkillSetPanel() : void
        {
            if (this._skillPanel)
            {
                this.skillPanel.openOrClose();
            }
            else
            {
                this.openSkillSetPanel();
            }
            return;
        }// end function

        public function openOrCloseAutoFight() : void
        {
            if (MapObj.getInstance().mapID != Params.COUNTRY_MAP_ID)
            {
                if (this._autoFightIcon)
                {
                    this.closeAutoFight();
                }
                else
                {
                    this.openAutoFight();
                }
            }
            else
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10300"));
            }
            return;
        }// end function

        public function copyFight(param1:Boolean = true) : void
        {
            if (param1)
            {
                AutoFightModel.fightRangeType = 2;
                this.openAutoFight();
            }
            else
            {
                this.closeAutoFight();
                AutoFightProtocol.getInstance().reqGetAssistantMessage();
            }
            return;
        }// end function

        public function openFightIcon() : void
        {
            if (!this._autoFightIcon)
            {
                this._autoFightIcon = new AutoFightIcon(null, null, "AutoFightIconSkin");
            }
            var _loc_1:* = new LayoutInfo();
            _loc_1.type = Layout.CENTER;
            _loc_1.offsetY = -200;
            Global.mainUIManager.addUI(this._autoFightIcon, _loc_1);
            return;
        }// end function

        public function openAutoFight(param1:Boolean = false) : void
        {
            var _loc_3:* = null;
            if (this._isAutoFighting)
            {
                return;
            }
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2 && _loc_2.zones_type == ZoneType.ZONES_RED_FORTRESS)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10302"));
                return;
            }
            this._isAutoFighting = true;
            AutoFightController.getInstance().closeAutoFind();
            if (!this._autoFightIcon)
            {
                this._autoFightIcon = new AutoFightIcon(null, null, "AutoFightIconSkin");
            }
            if (!this._autoGatherIcon)
            {
                this._autoGatherIcon = new AutoFightIcon(null, null, "AutoGatherIconSkin");
            }
            if (param1)
            {
                _loc_3 = this._autoGatherIcon;
            }
            else
            {
                _loc_3 = this._autoFightIcon;
            }
            _loc_3.addEventListener(AutoFightEvent.CLOSE_AUTO_FIGHT_ICON, this.onClickHandle);
            _loc_3.x = FrameworkGlobal.stage.stageWidth - 190 >> 1;
            _loc_3.y = (FrameworkGlobal.stage.stageHeight - 50 >> 1) - 150;
            Global.mainUIManager.addUI(_loc_3, null);
            FrameworkGlobal.stage.addEventListener(Event.RESIZE, this.resizeEventHandler);
            _loc_3.addEventListener(MouseEvent.MOUSE_DOWN, this.__drag);
            TaskGlobal.manager.setAutoTask(false);
            AutoFightManager.getInstance().autoFight(true, param1);
            if (this.fightPanel && this.fightPanel.btn_open)
            {
                this.fightPanel.btn_open.setText(LanguageCfgObj.getInstance().getByIndex("10303"));
            }
            if (!this.skillPanel)
            {
                AutoFightProtocol.getInstance().reqGetAssistantMessage();
            }
            return;
        }// end function

        private function resizeEventHandler(event:Event) : void
        {
            var _loc_2:* = null;
            if (this._autoFightIcon && this._autoFightIcon.parent)
            {
                _loc_2 = this._autoFightIcon;
            }
            if (this._autoGatherIcon && this._autoGatherIcon.parent)
            {
                _loc_2 = this._autoGatherIcon;
            }
            if (this._autoFindIcon && this._autoFindIcon.parent)
            {
                _loc_2 = this._autoFindIcon;
            }
            if (_loc_2)
            {
                _loc_2.x = FrameworkGlobal.stage.stageWidth - 190 >> 1;
                _loc_2.y = (FrameworkGlobal.stage.stageHeight - 50 >> 1) - 150;
            }
            return;
        }// end function

        private function onClickHandle(event:AutoFightEvent) : void
        {
            this.closeAutoFight();
            FrameworkGlobal.stage.focus = FrameworkGlobal.stage;
            return;
        }// end function

        public function closeAutoFight(param1:Boolean = true) : void
        {
            if (!this._isAutoFighting)
            {
                return;
            }
            this._isAutoFighting = false;
            if (this._autoFightIcon)
            {
                this._autoFightIcon.removeEventListener(AutoFightEvent.CLOSE_AUTO_FIGHT_ICON, this.onClickHandle);
                if (this._autoFightIcon.parent)
                {
                    this._autoFightIcon.parent.removeChild(this._autoFightIcon);
                }
                this._autoFightIcon.removeEventListener(MouseEvent.MOUSE_DOWN, this.__drag);
                this._autoFightIcon.finalize();
                this._autoFightIcon = null;
            }
            if (this._autoGatherIcon)
            {
                this._autoGatherIcon.removeEventListener(AutoFightEvent.CLOSE_AUTO_FIGHT_ICON, this.onClickHandle);
                if (this._autoGatherIcon.parent)
                {
                    this._autoGatherIcon.parent.removeChild(this._autoGatherIcon);
                }
                this._autoGatherIcon.removeEventListener(MouseEvent.MOUSE_DOWN, this.__drag);
                this._autoGatherIcon.finalize();
                this._autoGatherIcon = null;
            }
            if (this._autoFindIcon)
            {
                this._autoFindIcon.removeEventListener(AutoFightEvent.CLOSE_AUTO_FIGHT_ICON, this.onClickHandle);
                if (this._autoFindIcon.parent)
                {
                    this._autoFindIcon.parent.removeChild(this._autoFindIcon);
                }
                this._autoFindIcon.removeEventListener(MouseEvent.MOUSE_DOWN, this.__drag);
                this._autoFindIcon.finalize();
                this._autoFindIcon = null;
            }
            TaskGlobal.manager.setAutoTask(true);
            AutoFightManager.getInstance().force = true;
            AutoFightManager.getInstance().autoFight(false);
            AutoFightModel.fightRangeType = 1;
            if (this.fightPanel && this.fightPanel.btn_open)
            {
                this.fightPanel.btn_open.setText(LanguageCfgObj.getInstance().getByIndex("10304"));
            }
            PlayerControl.getInstance().setRateMcVisible(false);
            AutoFightManager.getInstance().setMounsterType(null);
            return;
        }// end function

        public function openAutoFind() : void
        {
            if (AutoFightManager.getInstance().isAutoFighting())
            {
                return;
            }
            if (!this._autoFindIcon)
            {
                this._autoFindIcon = new AutoFightIcon(null, null, "AutoFindIconSkin");
            }
            this._autoFindIcon.x = FrameworkGlobal.stage.stageWidth - 190 >> 1;
            this._autoFindIcon.y = (FrameworkGlobal.stage.stageHeight - 50 >> 1) - 150;
            Global.mainUIManager.addUI(this._autoFindIcon, null);
            FrameworkGlobal.stage.addEventListener(Event.RESIZE, this.resizeEventHandler);
            this._autoFindIcon.addEventListener(MouseEvent.MOUSE_DOWN, this.__drag);
            return;
        }// end function

        public function closeAutoFind(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            Player.state = State.NONE;
            if (this._autoFindIcon && this._autoFindIcon.parent)
            {
                this._autoFindIcon.parent.removeChild(this._autoFindIcon);
            }
            if (param1)
            {
                _loc_2 = RoleList.getInstance().player;
                MapControl.getInstance().stopPath(_loc_2);
                MapControl.getInstance().stopPath(_loc_2);
                Player.state = State.NONE;
            }
            return;
        }// end function

        public function update() : void
        {
            if (this.fightPanel)
            {
                this.fightPanel.setTableData();
            }
            if (this.sellPanel)
            {
                this.sellPanel.setTableData();
            }
            if (this.skillPanel)
            {
                this.skillPanel.setTableData();
            }
            if (this.vipPanel)
            {
                this.vipPanel.setTableData();
            }
            return;
        }// end function

        public function updateByPlayerLv(param1:int, param2:int) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param1 == 0)
            {
                return;
            }
            var _loc_3:* = false;
            var _loc_4:* = 0;
            var _loc_9:* = DrinkLogic.BLOOD_IDS.length;
            _loc_4 = 0;
            while (_loc_4 <= _loc_9)
            {
                
                _loc_6 = DrinkLogic.BLOOD_IDS[_loc_4];
                _loc_8 = PropUtil.createItemByCfg(_loc_6);
                if (_loc_8.q_level > param1 && _loc_8.q_level <= param2)
                {
                    AutoFightModel.autoBuyBloodType = _loc_4;
                    _loc_3 = true;
                }
                _loc_4++;
            }
            _loc_4 = 0;
            _loc_9 = DrinkLogic.MAGIC_IDS.length;
            while (_loc_4 <= _loc_9)
            {
                
                _loc_6 = DrinkLogic.MAGIC_IDS[_loc_4];
                _loc_8 = PropUtil.createItemByCfg(_loc_6);
                if (_loc_8.q_level > param1 && _loc_8.q_level <= param2)
                {
                    AutoFightModel.autoBuyMagicType = _loc_4;
                    _loc_3 = true;
                }
                _loc_4++;
            }
            if (this.vipPanel)
            {
                this.vipPanel.setBuyData();
            }
            if (_loc_3)
            {
                AutoFightModel.save();
            }
            return;
        }// end function

        private function __drag(event:MouseEvent) : void
        {
            this.target = event.currentTarget as AutoFightIcon;
            ToolKit.bringToTop(this.target);
            this.target.startDrag();
            this.target.stage.addEventListener(MouseEvent.MOUSE_UP, this.__stopDrag, false, 0, true);
            event.stopImmediatePropagation();
            return;
        }// end function

        private function __stopDrag(event:MouseEvent) : void
        {
            if (this.target)
            {
                this.target.stopDrag();
                if (this.target.stage)
                {
                    this.target.stage.removeEventListener(MouseEvent.MOUSE_UP, this.__stopDrag);
                }
            }
            return;
        }// end function

        public static function getInstance() : AutoFightController
        {
            if (instance == null)
            {
                instance = new AutoFightController;
            }
            return instance;
        }// end function

    }
}
