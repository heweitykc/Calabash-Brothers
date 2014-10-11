package com.game.equipstreng.view
{
    import avmplus.*;
    import com.*;
    import com.cfg.obj.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.clickstream.*;
    import com.game.guide.model.*;
    import flash.events.*;

    public class EquipForgeBox extends BaseBox
    {
        private var _equipStrengView:EquipStrengView;
        private var closeBtn:BaseButton;
        private var btn_Streng:BaseButton;
        private var btn_Process:BaseButton;
        private var btn_Compose:BaseButton;
        private var btn_suit:BaseButton;
        private var btn_suitStrength:BaseButton;
        private var btn_suitSplit:BaseButton;
        private var _type:int = 1;
        private var btnAry:Array;

        public function EquipForgeBox()
        {
            this.btnAry = [];
            loadDisplay("res/equipForge.swf");
            return;
        }// end function

        public function get equipStrengView() : EquipStrengView
        {
            if (!this._equipStrengView)
            {
                this._equipStrengView = new EquipStrengView();
                addChild(this._equipStrengView);
            }
            return this._equipStrengView;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("equipForge");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn_Process = new BaseButton(getDisplayChildByName("btn_Process"));
            this.btn_Streng = new BaseButton(getDisplayChildByName("btn_Streng"));
            this.btn_Compose = new BaseButton(getDisplayChildByName("btn_Compose"));
            this.btn_suit = new BaseButton(getDisplayChildByName("btn_suit"));
            this.btn_suitStrength = new BaseButton(getDisplayChildByName("btn_suitStrength"));
            this.btn_suitSplit = new BaseButton(getDisplayChildByName("btn_suitSplit"));
            this.btn_Streng.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_Process.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_Compose.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_suit.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_suitStrength.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_suitSplit.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_Streng.setText(LanguageCfgObj.getInstance().getByIndex("10617"), true);
            this.btn_Process.setText(LanguageCfgObj.getInstance().getByIndex("10618"), true);
            this.btn_Compose.setText(LanguageCfgObj.getInstance().getByIndex("10619"), true);
            this.btn_suit.setText(LanguageCfgObj.getInstance().getByIndex("10616"), true);
            this.btn_suitStrength.setText(LanguageCfgObj.getInstance().getByIndex("12410"), true);
            this.btn_suitSplit.setText(LanguageCfgObj.getInstance().getByIndex("12443"), true);
            this.btnAry.push(this.btn_Streng);
            this.btnAry.push(this.btn_Process);
            this.btnAry.push(this.btn_Compose);
            this.btnAry.push(this.btn_suit);
            this.btnAry.push(this.btn_suitStrength);
            this.btnAry.push(this.btn_suitSplit);
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            setWH(this.display.width, this.display.height);
            this.type = this._type;
            this.choose(this.type);
            if (FrameworkGlobal.language == "ft")
            {
                var _loc_1:* = false;
                this.btn_suitStrength.visible = false;
                this.btn_suit.visible = _loc_1;
            }
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.btnAry.indexOf(event.target);
            _loc_2++;
            if (this._type == _loc_2)
            {
                return;
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().SUIT_OPT_TEAM)) == 0)
            {
                if (_loc_2 == 4)
                {
                    Global.popManager.addedToMouseCue(StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("12437"), TaskCfgObj.getInstance().getOpenLevelByTeam(GuideConfigObj.getInstance().SUIT_OPT_TEAM)));
                    return;
                }
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().SUIT_OPT_TEAM)) == 0)
            {
                if (_loc_2 == 5)
                {
                    Global.popManager.addedToMouseCue(StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("12438"), TaskCfgObj.getInstance().getOpenLevelByTeam(GuideConfigObj.getInstance().SUIT_OPT_TEAM)));
                    return;
                }
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().SUIT_OPT_TEAM)) == 0)
            {
                if (_loc_2 == 6)
                {
                    Global.popManager.addedToMouseCue(StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("12444"), TaskCfgObj.getInstance().getOpenLevelByTeam(GuideConfigObj.getInstance().SUIT_OPT_TEAM)));
                    return;
                }
            }
            this.type = _loc_2;
            this.choose(this._type);
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            this.equipStrengView.clear();
            FrameworkGlobal.sendMsg(new WndCloseEvt(WndCloseEvt.CLOSE, getQualifiedClassName(this)));
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.equipStrengView.clear();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.choose(this._type);
            return;
        }// end function

        private function choose(param1:int = 1) : void
        {
            if (this.btnAry[(param1 - 1)])
            {
                this.btnAry[(param1 - 1)].selected = true;
            }
            this.equipStrengView.update(param1);
            if (isOpen)
            {
                if (param1 == 1)
                {
                    ClickStream.add(ClickStreamId.OPEN_QiangHua);
                }
                else if (param1 == 2)
                {
                    ClickStream.add(ClickStreamId.OPEN_ZuiJia);
                }
            }
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            var _loc_2:* = 1;
            while (_loc_2 <= this.btnAry.length)
            {
                
                if (param1 == _loc_2)
                {
                    this.btnAry[(_loc_2 - 1)].selected = true;
                }
                else
                {
                    this.btnAry[(_loc_2 - 1)].selected = false;
                }
                _loc_2++;
            }
            return;
        }// end function

    }
}
