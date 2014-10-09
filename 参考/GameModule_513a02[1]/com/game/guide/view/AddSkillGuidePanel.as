package com.game.guide.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.task.*;
    import com.greensock.*;
    import com.model.vo.*;
    import com.view.tipcell.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class AddSkillGuidePanel extends BaseBox implements IGuide
    {
        private var _info:SkillInfo;
        private var _extraTxt:String;
        private var _layoutInfo:LayoutInfo;
        private var _txt:TextField;
        private var icon:Image;
        private var _closeBtn:BaseButton;

        public function AddSkillGuidePanel()
        {
            setWH(309, 80);
            loadDisplay("res/addskillguide.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("add_skill_guide_panel");
            this.initUI();
            this.updateView();
            super.displayReady();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (!this._layoutInfo)
            {
                this._layoutInfo = new LayoutInfo(Layout.CENTER);
            }
            Global.popManager.addGuideDisplayObject(this);
            Layout.layoutMC(FrameworkGlobal.stage, this, Layout.CENTER);
            this.updateView();
            TweenLite.delayedCall(TaskGlobal.AUTO_SKILL_AWARD_OK, this.delayAutoClick);
            return;
        }// end function

        private function delayAutoClick() : void
        {
            dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return;
        }// end function

        override public function close() : void
        {
            var _loc_1:* = null;
            TweenLite.killDelayedCallsTo(this.close);
            if (this._info && this.icon && this.icon.parent)
            {
                _loc_1 = this.icon.parent.localToGlobal(new Point(this.icon.x, this.icon.y));
                SkillGuideControl.getInstance().beginSkillFly(this._info, _loc_1);
            }
            super.close();
            if (parent)
            {
                parent.removeChild(this);
            }
            this._info = null;
            switch(GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_SKILL_TEAM)))
            {
                case 0:
                {
                    GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().FIRST_SKILL_TEAM), 1);
                    break;
                }
                case 1:
                {
                    GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().FIRST_SKILL_TEAM), 2);
                    GuideMultiControl.getInstance().finishTeamGuide(int(GuideConfigObj.getInstance().FIRST_SKILL_TEAM));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._txt = getDisplayChildByName("txt");
            this._closeBtn = new BaseButton(getDisplayChildByName("closeBtn"));
            this.icon = new Image();
            this.icon.move(10, 10);
            addChild(this.icon);
            return;
        }// end function

        public function updateView() : void
        {
            if (UILoaded && this._info)
            {
                if (this._extraTxt)
                {
                    this._txt.htmlText = this._extraTxt;
                }
                else
                {
                    this._txt.htmlText = LanguageCfgObj.getInstance().getByIndex("12056") + this._info.q_skillName;
                }
                this.icon.load(this._info.iconUrl);
                ItemTips.create(this.icon, this._info, SkillTips);
                this.addEventListener(MouseEvent.CLICK, this.__clickHandler);
                if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_SKILL_TEAM)) != 2)
                {
                    this.registerGuide();
                    GuideMultiControl.getInstance().beginGuide(int(GuideConfigObj.getInstance().FIRST_SKILL_TEAM));
                }
            }
            return;
        }// end function

        public function get info() : SkillInfo
        {
            return this._info;
        }// end function

        public function set info(param1:SkillInfo) : void
        {
            this._info = param1;
            return;
        }// end function

        public function get extraTxt() : String
        {
            return this._extraTxt;
        }// end function

        public function set extraTxt(param1:String) : void
        {
            this._extraTxt = param1;
            return;
        }// end function

        private function __clickHandler(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideMultiControl.getInstance().registerGuide(this, this, GuideConfigObj.getInstance().FIRST_SKILL_GUIDE_ID_1);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return UILoaded && isOpen;
        }// end function

    }
}
