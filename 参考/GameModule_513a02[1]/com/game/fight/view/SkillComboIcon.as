package com.game.fight.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.text.*;

    public class SkillComboIcon extends BaseSprite
    {
        private var _image:Image;
        private var _frame:Image;
        private var _txtStep:TextField;

        public function SkillComboIcon()
        {
            this.initBack();
            this.initIcon();
            return;
        }// end function

        private function initBack() : void
        {
            this.graphics.beginFill(16777215, 0);
            this.graphics.drawRect(0, 0, 80, 102);
            this.graphics.endFill();
            this.setWH(80, 102);
            return;
        }// end function

        private function initIcon() : void
        {
            var _loc_1:* = SkillCfgObj.getInstance().getSkillInfoById(SpecialSkillID.SKILL_LIAN_JI);
            this._frame = new Image();
            this._frame.move(0, 0);
            this._frame.load("res/image/skill/skillComboFrame.png");
            this.addChild(this._frame);
            this._image = new Image();
            this._image.move(12, 12);
            this._image.load(_loc_1.iconUrl);
            this.addChild(this._image);
            this._txtStep = new TextField();
            this._txtStep.defaultTextFormat = new TextFormat(null, null, 16748800, null, null, null, null, null, "center");
            this._txtStep.height = 30;
            this._txtStep.width = 80;
            this._txtStep.y = 72;
            this._txtStep.mouseEnabled = false;
            this.addChild(this._txtStep);
            this.mouseEnabled = false;
            return;
        }// end function

        public function setStepInfo(param1:int) : void
        {
            var _loc_3:* = null;
            if (param1 < 1 || param1 > 3)
            {
                return;
            }
            var _loc_2:* = new VMCView();
            this.addChild(_loc_2);
            _loc_2.loadRes("res/effect/skill/skillComboIcon.png");
            _loc_2.move(38, 38);
            _loc_2.auto = true;
            _loc_2.updatePose("90");
            if (param1 == 3)
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("12431");
            }
            else
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("12430");
                _loc_3 = StringUtil.languageReplace(_loc_3, [param1]);
            }
            this._txtStep.text = _loc_3;
            return;
        }// end function

    }
}
