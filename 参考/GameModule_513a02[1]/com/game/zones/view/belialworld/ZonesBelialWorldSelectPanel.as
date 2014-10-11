package com.game.zones.view.belialworld
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import com.util.*;
    import flash.events.*;
    import flash.text.*;

    public class ZonesBelialWorldSelectPanel extends BaseBox
    {
        private var _btnAgree:BaseButton;
        private var _btnRefuse:BaseButton;
        private var _btnClose:BaseButton;
        private var _info:ResZoneTeamNoticeToClientMessage;
        private var _txtCaptainName:TextField;
        private var _txtInstanceName:TextField;
        private var _txtTitle:TextField;
        private var _downTime:DownTimer;
        private var _txtDownTime:TextField;

        public function ZonesBelialWorldSelectPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this._downTime = new DownTimer();
            super(param1, param2, param3, param4);
            loadDisplay("res/zonebelialworld.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("zonebelialworldselect");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._btnAgree = new BaseButton(getDisplayChildByName("btn_agree"));
            this._btnAgree.setText(LanguageCfgObj.getInstance().getByIndex("11499"));
            this._btnRefuse = new BaseButton(getDisplayChildByName("btn_refuse"));
            this._btnRefuse.setText(LanguageCfgObj.getInstance().getByIndex("11500"));
            this._btnClose = new BaseButton(getDisplayChildByName("btn_close"));
            this._txtCaptainName = TextField(getDisplayChildByName("txt_captain_name"));
            this._txtInstanceName = TextField(getDisplayChildByName("txt_instance_name"));
            this._txtDownTime = TextField(getDisplayChildByName("txt_down_time"));
            this._txtTitle = TextField(getDisplayChildByName("txt_title"));
            this._txtCaptainName.mouseEnabled = false;
            this._txtDownTime.mouseEnabled = false;
            this._txtInstanceName.mouseEnabled = false;
            this.freshPanel();
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this._downTime.callBack = this.callDownTime;
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnAgree:
                {
                    this.clickBtnHandler(2);
                    break;
                }
                case this._btnRefuse:
                {
                    this.clickBtnHandler(1);
                    this.close();
                    break;
                }
                case this._btnClose:
                {
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function clickBtnHandler(param1:int) : void
        {
            if (this._info)
            {
                ZonesControl.getInstance().reqZoneTeamSelectToGame(param1, this._info.zoneid);
                this.close();
            }
            return;
        }// end function

        private function freshPanel() : void
        {
            var _loc_1:* = null;
            if (!UILoaded)
            {
                return;
            }
            if (this._info)
            {
                this._txtCaptainName.text = this._info.leadername;
                _loc_1 = ZonesCloneCfg.getInstance().getZonesInfoFromId(this._info.zoneid);
                this._txtInstanceName.text = _loc_1.duplicate_name;
                this._downTime.count = this._info.waittime * 1000;
                this._txtTitle.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12338"), [_loc_1.duplicate_name]);
            }
            return;
        }// end function

        private function callDownTime(param1:int, param2:String) : void
        {
            this._txtDownTime.text = int(param1 / 1000).toString();
            if (param1 <= 0)
            {
                this._txtDownTime.text = "";
                this.close();
            }
            return;
        }// end function

        public function enterDownClose() : void
        {
            this._downTime.count = 0;
            return;
        }// end function

        public function set info(param1:ResZoneTeamNoticeToClientMessage) : void
        {
            this._info = param1;
            this.freshPanel();
            return;
        }// end function

        public function get info() : ResZoneTeamNoticeToClientMessage
        {
            return this._info;
        }// end function

    }
}
