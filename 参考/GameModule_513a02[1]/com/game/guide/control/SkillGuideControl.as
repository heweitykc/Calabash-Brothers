package com.game.guide.control
{
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.game.guide.view.*;
    import com.game.operationpanel.control.*;
    import com.game.operationpanel.view.*;
    import com.game.shortcut.control.*;
    import com.greensock.*;
    import com.model.vo.*;
    import flash.geom.*;

    public class SkillGuideControl extends Object
    {
        private var _curSkillInfo:SkillInfo;
        private var _flySkill:SkillInfo;
        public var preSkillId:int;
        private var _replace:Boolean;
        private var _finishFunc:Function;
        private var _panel:AddSkillGuidePanel;
        private var flyIcon:Image;
        private var emptyBox:ShortcutBox;
        private static var _instance:SkillGuideControl;

        public function SkillGuideControl()
        {
            return;
        }// end function

        public function beginAddSkillGuide(param1:SkillInfo, param2:String = null, param3:Function = null, param4:Boolean = false) : void
        {
            this._curSkillInfo = param1;
            this._finishFunc = param3;
            this._replace = param4;
            if (!this._panel)
            {
                this._panel = new AddSkillGuidePanel();
            }
            this._panel.info = param1;
            this._panel.extraTxt = param2;
            this._panel.open();
            return;
        }// end function

        public function beginSkillFly(param1:SkillInfo, param2:Point) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!this.flyIcon)
            {
                this.flyIcon = new Image();
            }
            var _loc_3:* = OperationPanelControl.getInstance().getSkillGridEmpty(this._replace ? (param1) : (null));
            if (_loc_3 && _loc_3.parent)
            {
                this.emptyBox = _loc_3;
                this._flySkill = param1;
                this.flyIcon.load(param1.iconUrl);
                _loc_4 = _loc_3.parent.localToGlobal(new Point(_loc_3.x, _loc_3.y));
            }
            else
            {
                _loc_5 = OperationPanelControl.getInstance().getSkillBtn();
                if (_loc_5 && _loc_5.parent)
                {
                    this._flySkill = param1;
                    this.flyIcon.load(param1.iconUrl);
                    _loc_4 = _loc_5.parent.localToGlobal(new Point(_loc_5.x, _loc_5.y));
                }
            }
            if (_loc_4)
            {
                this.flyIcon.move(param2.x, param2.y);
                FrameworkGlobal.stage.addChild(this.flyIcon);
                TweenLite.to(this.flyIcon, 0.4, {x:_loc_4.x, y:_loc_4.y, onComplete:this.__arrive});
            }
            return;
        }// end function

        private function __arrive() : void
        {
            var _loc_1:* = null;
            TweenLite.killTweensOf(this.flyIcon);
            this.flyIcon.smoothing = true;
            _loc_1 = new Point(this.flyIcon.x, this.flyIcon.y);
            this.flyIcon.x = this.flyIcon.x - (this.flyIcon.width * 0.2 >> 1);
            this.flyIcon.y = this.flyIcon.y - (this.flyIcon.height * 0.2 >> 1);
            var _loc_2:* = 1.2;
            this.flyIcon.scaleY = 1.2;
            this.flyIcon.scaleX = _loc_2;
            TweenLite.to(this.flyIcon, 0.3, {x:_loc_1.x, y:_loc_1.y, scaleX:1, scaleY:1, onComplete:this.__finish});
            return;
        }// end function

        private function __finish() : void
        {
            TweenLite.killTweensOf(this.flyIcon);
            this.flyIcon.parent.removeChild(this.flyIcon);
            this.flyIcon.dispose();
            this.flyIcon = null;
            if (this.emptyBox)
            {
                this.preSkillId = this._flySkill.q_skillID;
                if (this._finishFunc != null)
                {
                    this._finishFunc(this.preSkillId);
                }
                else
                {
                    ShortcutControl.getInstance().addShortCutHandle(this.emptyBox.gridId, this._flySkill.skillId, this._flySkill.q_skillID, 2);
                }
            }
            this._flySkill = null;
            this.emptyBox = null;
            return;
        }// end function

        public static function getInstance() : SkillGuideControl
        {
            var _loc_1:* = new SkillGuideControl;
            _instance = new SkillGuideControl;
            return _instance || _loc_1;
        }// end function

    }
}
