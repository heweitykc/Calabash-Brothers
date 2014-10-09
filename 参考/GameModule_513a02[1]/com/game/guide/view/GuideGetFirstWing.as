package com.game.guide.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.image.*;
    import com.f1.vmc.*;
    import com.game.backpack.control.*;
    import com.game.backpack.model.*;
    import com.game.task.*;
    import com.game.task.model.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;

    public class GuideGetFirstWing extends BaseBox
    {
        private var WIDTH:int = 800;
        private var Height:int = 600;
        private var _back:Sprite;
        private var _imgWing:Image;
        private var _timeLineLite:TimelineLite;
        private var _vmcEffect:VMCView;
        private var _flashCarrier:BaseSprite;
        private var _imgName:Image;
        private static var _instance:GuideGetFirstWing;

        public function GuideGetFirstWing()
        {
            _peaceBox = ["*"];
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            this.drawBack();
            this.drawEffect();
            this.drawflashCarrier();
            this.drawWing();
            return;
        }// end function

        private function drawBack() : void
        {
            this._back = new Sprite();
            this._back.graphics.beginFill(2236962, 0);
            this._back.graphics.drawRect(0, 0, this.WIDTH, this.Height);
            this._back.graphics.endFill();
            this.addChild(this._back);
            return;
        }// end function

        private function drawflashCarrier() : void
        {
            this._flashCarrier = new BaseSprite();
            this._flashCarrier.x = this.WIDTH / 2;
            this._flashCarrier.y = this.Height / 2;
            this.addChild(this._flashCarrier);
            return;
        }// end function

        private function drawEffect() : void
        {
            this._vmcEffect = new VMCView();
            this._vmcEffect.move(this.WIDTH / 2, this.Height / 2);
            this.addChild(this._vmcEffect);
            this._vmcEffect.loadRes("res/effect/guideFirstWing.png");
            this._vmcEffect.auto = true;
            this._vmcEffect.updatePose("90", false, false, true);
            return;
        }// end function

        private function drawWing() : void
        {
            this._imgWing = new Image();
            var job:* = UserObj.getInstance().playerInfo.job;
            job = (job - 1) % 3 + 1;
            this._imgWing.load("res/image/guide/wing" + job + ".png", function () : void
            {
                _imgWing.x = (-_imgWing.width) / 2;
                _imgWing.y = (-_imgWing.height) / 2;
                return;
            }// end function
            );
            this._flashCarrier.addChild(this._imgWing);
            this._imgName = new Image();
            this._imgName.move(-143, 33);
            this._imgName.load("res/image/guide/wingGetWord.png");
            this._flashCarrier.addChild(this._imgName);
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            this.preFlash();
            this.createFlash();
            return;
        }// end function

        private function preFlash() : void
        {
            this._flashCarrier.scaleX = 0.2;
            this._flashCarrier.scaleY = 0.2;
            return;
        }// end function

        private function createFlash() : void
        {
            if (!this._timeLineLite)
            {
                this._timeLineLite = new TimelineLite();
            }
            this._timeLineLite.append(new TweenLite(this._flashCarrier, 1, {scaleX:1, scaleY:1, x:this.WIDTH / 2, y:this.Height / 2}));
            this._timeLineLite.append(new TweenLite(this, 3, {onComplete:this.onComplete}));
            return;
        }// end function

        public function onComplete() : void
        {
            this.close();
            return;
        }// end function

        override public function open() : void
        {
            Global.popManager.addUI(this, new LayoutInfo(Layout.CENTER, 0, -120));
            return;
        }// end function

        override public function close() : void
        {
            this.clean();
            TaskGlobal.manager.continueTask(TaskGlobal.currentTask as TaskMsgVO);
            this.takeIn();
            Global.popManager.removeUI(this);
            return;
        }// end function

        private function takeIn() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = BackpackObj.getInstance().getGoodsByType(20);
            var _loc_2:* = _loc_1.length;
            if (_loc_2 > 0)
            {
                _loc_3 = _loc_1[0] as EquipmentInfo;
                if (_loc_3)
                {
                    BackPackControl.getInstance().equip(_loc_3);
                }
            }
            return;
        }// end function

        private function clean() : void
        {
            if (this._imgWing && this._imgWing.parent)
            {
                this._imgWing.parent.removeChild(this._imgWing);
            }
            if (this._imgWing && this._imgWing.parent)
            {
                this._imgWing.parent.removeChild(this._imgWing);
            }
            return;
        }// end function

        public static function getInstance() : GuideGetFirstWing
        {
            if (!_instance)
            {
                _instance = new GuideGetFirstWing;
                Global.popManager.addPop(_instance, true, true, true, true);
            }
            return _instance;
        }// end function

    }
}
