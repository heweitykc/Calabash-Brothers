package com.game.store.view
{
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.backpack.view.itemrenderers.*;
    import com.game.store.events.*;
    import com.staticdata.*;
    import flash.display.*;
    import interfaces.*;

    public class StoreItem extends Itemrenderer
    {
        private var lockBack:Bitmap;
        private var _lock:Boolean;
        private var _isEffect:Boolean;
        private var _effect:VMCView;

        public function StoreItem()
        {
            this.lockBack = ToolKit.getNewDO("lockBackImage") as Bitmap;
            this.lockBack.x = 2;
            this.lockBack.y = 2;
            this.setCountTxtXY(_w - 7, _h - 18);
            this.addChild(this.lockBack);
            this.lockBack.visible = false;
            return;
        }// end function

        override protected function initHitArea() : void
        {
            _hitShape.graphics.beginFill(0, 0);
            _hitShape.graphics.drawRect(-5, -5, _backImage.width + 5, _backImage.height + 5);
            _hitShape.graphics.endFill();
            this.addChild(_hitShape);
            this.hitArea = _hitShape;
            return;
        }// end function

        public function get lock() : Boolean
        {
            return this._lock;
        }// end function

        public function set lock(param1:Boolean) : void
        {
            this._lock = param1;
            this.lockBack.visible = param1;
            return;
        }// end function

        override public function completeDrag(param1:Object, param2:IDragItem = null, param3:IDragItem = null) : void
        {
            var _loc_4:* = null;
            if (place == Params.ITEM_PLACE_STORE && param2.getKey() == Params.ITEM_PLACE_BACKPACK)
            {
                _loc_4 = new Object();
                _loc_4.info = param1;
                _loc_4.item = param2;
                _loc_4.targetItem = param3;
                StoreDispatcher.dispatch().dispatchEvent(new StoreEvent(StoreEvent.ITEM_MOVE_TO_STORE, _loc_4));
            }
            if (place == Params.ITEM_PLACE_STORE && param2.getKey() == Params.ITEM_PLACE_STORE)
            {
                _loc_4 = new Object();
                _loc_4.info = param1;
                _loc_4.item = param2;
                _loc_4.targetItem = param3;
                StoreDispatcher.dispatch().dispatchEvent(new StoreEvent(StoreEvent.ITEM_MOVE_INNER_STORE, _loc_4));
            }
            return;
        }// end function

        public function get isEffect() : Boolean
        {
            return this._isEffect;
        }// end function

        public function set isEffect(param1:Boolean) : void
        {
            this._isEffect = param1;
            this.setEffect();
            return;
        }// end function

        protected function setEffect() : void
        {
            if (this._isEffect)
            {
                if (!this._effect)
                {
                    this._effect = new VMCView();
                    this._effect.move(35, 35);
                    this._effect.loadRes("res/effect/skillbox.png", null, false, function () : void
            {
                _effect.width = 53;
                _effect.height = 53;
                return;
            }// end function
            );
                    this._effect.updatePose("90", true);
                    this._effect.width = 53;
                    this._effect.height = 53;
                    this._effect.auto = true;
                    this.addChild(this._effect);
                }
            }
            else if (this._effect)
            {
                this._effect.finalize();
                this._effect = null;
            }
            return;
        }// end function

    }
}
