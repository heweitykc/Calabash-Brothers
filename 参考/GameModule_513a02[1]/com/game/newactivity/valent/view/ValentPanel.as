package com.game.newactivity.valent.view
{
    import __AS3__.vec.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.stripe.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.game.newactivity.valent.control.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ValentPanel extends BaseBox
    {
        private var btnHelp:BaseButton;
        private var btnClose:BaseButton;
        private var btnSubmit1:BaseButton;
        private var btnSubmit2:BaseButton;
        private var btnSubmit3:BaseButton;
        private var mcBox1:MovieClip;
        private var mcBox2:MovieClip;
        private var mcBox3:MovieClip;
        private var txtAwards1:TextField;
        private var txtAwards2:TextField;
        private var txtAwards3:TextField;
        private var txtSubmitCount:TextField;
        private var stripSubit1:Stripe;
        private var stripSubit2:Stripe;
        private var stripSubit3:Stripe;
        private var _info:NewActivityInfo;
        private var mcHelpTips:Sprite;
        private var wordTipsBox1:String;
        private var wordTipsBox2:String;
        private var wordTipsBox3:String;
        private static const COUNT_STEP1:int = 500;
        private static const COUNT_STEP2:int = 1500;
        private static const COUNT_STEP3:int = 7000;

        public function ValentPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            super(param1, param2, param3, param4);
            loadDisplay("res/valentineDays.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("valent_view");
            this.initUI();
            this.addEvents();
            super.displayReady();
            this.initInfo();
            return;
        }// end function

        private function initInfo() : void
        {
            this._info = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_VALENTINE_DAYS);
            if (this._info && !this._info.isDetailInit)
            {
                NewActivityControl.getInstance().getActivityInfo(this._info.activityId);
            }
            if (this._info)
            {
                this._info.addEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.updateByActivityInfo);
            }
            var _loc_1:* = this._info.q_condDesc.split("|");
            this.txtAwards1.htmlText = _loc_1[0];
            this.txtAwards2.htmlText = _loc_1[1];
            this.txtAwards3.htmlText = _loc_1[2];
            this.wordTipsBox1 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12445"), [COUNT_STEP1]);
            this.wordTipsBox2 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12446"), [COUNT_STEP2]);
            this.wordTipsBox3 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12447"), [COUNT_STEP3]);
            StringTip.create(this.mcBox1, this.wordTipsBox1);
            StringTip.create(this.mcBox2, this.wordTipsBox2);
            StringTip.create(this.mcBox3, this.wordTipsBox3);
            return;
        }// end function

        private function initUI() : void
        {
            this.btnHelp = new BaseButton(getDisplayChildByName("btn_help"));
            this.mcHelpTips = Sprite(getDisplayChildByName("help_tips"));
            this.mcHelpTips.visible = false;
            this.btnClose = new BaseButton(getDisplayChildByName("btn_close"));
            this.btnSubmit1 = new BaseButton(getDisplayChildByName("btn_submit1"));
            this.btnSubmit2 = new BaseButton(getDisplayChildByName("btn_submit2"));
            this.btnSubmit3 = new BaseButton(getDisplayChildByName("btn_submit3"));
            this.mcBox1 = MovieClip(getDisplayChildByName("mc_box1"));
            this.mcBox2 = MovieClip(getDisplayChildByName("mc_box2"));
            this.mcBox3 = MovieClip(getDisplayChildByName("mc_box3"));
            this.mcBox1.gotoAndStop(1);
            this.mcBox2.gotoAndStop(1);
            this.mcBox3.gotoAndStop(1);
            this.txtAwards1 = TextField(getDisplayChildByName("txt_awards1"));
            this.txtAwards2 = TextField(getDisplayChildByName("txt_awards2"));
            this.txtAwards3 = TextField(getDisplayChildByName("txt_awards3"));
            this.txtAwards1.mouseEnabled = false;
            this.txtAwards2.mouseEnabled = false;
            this.txtAwards3.mouseEnabled = false;
            this.txtSubmitCount = TextField(getDisplayChildByName("txt_submit_count"));
            this.txtSubmitCount.text = "0/" + COUNT_STEP3;
            this.stripSubit1 = new Stripe(getDisplayChildByName("strip_submit1"));
            this.stripSubit2 = new Stripe(getDisplayChildByName("strip_submit2"));
            this.stripSubit3 = new Stripe(getDisplayChildByName("strip_submit3"));
            ValentControl.getInstance().reqOpenPainInfo();
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClick);
            this.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            return;
        }// end function

        protected function mouseClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btnClose:
                {
                    this.close();
                    break;
                }
                case this.btnSubmit1:
                {
                    this.submit(0);
                    break;
                }
                case this.btnSubmit2:
                {
                    this.submit(1);
                    break;
                }
                case this.btnSubmit3:
                {
                    this.submit(2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function mouseOver(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btnHelp:
                {
                    this.mcHelpTips.visible = true;
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        protected function mouseOut(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btnHelp:
                {
                    this.mcHelpTips.visible = false;
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function submit(param1:int) : void
        {
            NewActivityControl.getInstance().getActivityReward(this._info.activityId, param1);
            return;
        }// end function

        protected function updateByActivityInfo(event:Event) : void
        {
            return;
        }// end function

        public function setPainInfo(param1:int, param2:Vector.<ItemInfo>) : void
        {
            if (!UILoaded)
            {
                return;
            }
            if (param2.length > 0)
            {
                this.playEffect();
            }
            this.txtSubmitCount.text = (param1 > COUNT_STEP3 ? (COUNT_STEP3) : (param1)) + "/" + COUNT_STEP3;
            this.stripSubit1.setValue(param1, COUNT_STEP1, false, "", false);
            if (param1 >= COUNT_STEP1)
            {
                this.mcBox1.gotoAndStop(2);
                this.wordTipsBox1 = LanguageCfgObj.getInstance().getByIndex("12448");
                StringTip.update(this.mcBox1, this.wordTipsBox1);
                this.stripSubit2.setValue(param1 - COUNT_STEP1, COUNT_STEP2 - COUNT_STEP1, false, "", false);
            }
            else
            {
                this.stripSubit2.setValue(0, COUNT_STEP2 - COUNT_STEP1, false, "", false);
            }
            if (param1 >= COUNT_STEP2)
            {
                this.mcBox2.gotoAndStop(2);
                this.wordTipsBox2 = LanguageCfgObj.getInstance().getByIndex("12449");
                StringTip.update(this.mcBox2, this.wordTipsBox2);
                this.stripSubit3.setValue(param1 - COUNT_STEP2, COUNT_STEP3 - COUNT_STEP2, false, "", false);
            }
            else
            {
                this.stripSubit3.setValue(0, COUNT_STEP3 - COUNT_STEP2 - COUNT_STEP1, false, "", false);
            }
            if (param1 >= COUNT_STEP3)
            {
                this.mcBox3.gotoAndStop(2);
                this.wordTipsBox3 = LanguageCfgObj.getInstance().getByIndex("12450");
                StringTip.update(this.mcBox3, this.wordTipsBox3);
            }
            return;
        }// end function

        private function playEffect() : void
        {
            var _loc_1:* = new VMCView();
            _loc_1.auto = true;
            _loc_1.move(251, 161);
            _loc_1.loadRes("res/effect/activity/valentineDaysEffect.png");
            this.addChild(_loc_1);
            _loc_1.updatePose("90", false, false, true, true);
            return;
        }// end function

    }
}
