package com.game.autopk.mediator
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.autopk.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.view.*;
    import com.game.clickstream.*;
    import com.game.map.model.*;
    import com.game.zones.control.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;

    public class AutoFightMediator extends Object
    {
        private var panel:AutoFightPanel;

        public function AutoFightMediator(param1:AutoFightPanel)
        {
            this.panel = param1;
            param1.btn_vip.addEventListener(MouseEvent.CLICK, this.onVipClickHandle);
            param1.btn_skill.addEventListener(MouseEvent.CLICK, this.onSkillClickHandle);
            param1.btn_sell.addEventListener(MouseEvent.CLICK, this.onSellClickHandle);
            param1.btn_open.addEventListener(MouseEvent.CLICK, this.onSaveAndStartHandle);
            param1.close_btn.addEvtListener(MouseEvent.CLICK, this.onClosePanel);
            return;
        }// end function

        private function onVipClickHandle(event:MouseEvent) : void
        {
            if (AutoFightController.getInstance().vipPanel)
            {
                if (!AutoFightController.getInstance().vipPanel.isOpen)
                {
                    AutoFightController.getInstance().vipPanel.setTableData();
                }
            }
            AutoFightController.getInstance().openOrCloseVipSetPanel();
            ClickStream.add(ClickStreamId.CLICK_ZhanDouZhuShou_XunHuanGuaJi);
            return;
        }// end function

        private function onSkillClickHandle(event:MouseEvent) : void
        {
            if (AutoFightController.getInstance().skillPanel)
            {
                if (!AutoFightController.getInstance().skillPanel.isOpen)
                {
                    AutoFightController.getInstance().skillPanel.setTableData();
                }
            }
            AutoFightController.getInstance().openOrCloseSkillSetPanel();
            return;
        }// end function

        private function onSellClickHandle(event:MouseEvent) : void
        {
            if (AutoFightController.getInstance().sellPanel)
            {
                if (!AutoFightController.getInstance().sellPanel.isOpen)
                {
                    AutoFightController.getInstance().sellPanel.setTableData();
                }
            }
            AutoFightController.getInstance().openOrCloseSellSetPanel();
            return;
        }// end function

        private function onSaveAndStartHandle(event:MouseEvent) : void
        {
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2 && _loc_2.zones_type == ZoneType.ZONES_RED_FORTRESS)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10305"));
                return;
            }
            var _loc_3:* = AutoFightManager.getInstance().isAutoFighting();
            if (!_loc_3)
            {
                this.panel.close();
                this.panel.btn_open.setText(LanguageCfgObj.getInstance().getByIndex("10306"));
                if (!ZonesControl.getInstance().autoFight())
                {
                    AutoFightController.getInstance().openAutoFight();
                }
            }
            else
            {
                this.panel.btn_open.setText(LanguageCfgObj.getInstance().getByIndex("10307"));
                if (!ZonesControl.getInstance().autoFight())
                {
                    AutoFightController.getInstance().closeAutoFight();
                }
            }
            return;
        }// end function

        private function onClosePanel(event:MouseEvent) : void
        {
            AutoFightController.getInstance().openOrCloseFightPanel();
            return;
        }// end function

    }
}
