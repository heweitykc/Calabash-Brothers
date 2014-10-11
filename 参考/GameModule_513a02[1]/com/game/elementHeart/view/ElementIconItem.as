package com.game.elementHeart.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.elementHeart.control.*;
    import com.game.elementHeart.event.*;
    import com.game.elementHeart.model.*;
    import com.manager.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import interfaces.*;

    public class ElementIconItem extends IconBase implements IDragItem
    {
        public var type:int = -1;
        private var _info:ElementHeartInfo;
        protected var _isLock:Boolean = false;
        protected var _isDrag:Boolean = true;
        protected var _elementEffect:VMCView = null;
        protected var _lockImage:Bitmap = null;
        protected var _openLock:Bitmap = null;
        protected var _index:int = 0;
        protected var _accpetKey:Array;
        private static const LANG:String = ElementHeartControl.LANG;
        private static var confirm:Boolean = true;

        public function ElementIconItem(param1:String = "magicBook_skilllock")
        {
            super(param1);
            _place = Params.ITEM_ELEMENT_HEART;
            this._accpetKey = [Params.ITEM_ELEMENT_HEART];
            this._elementEffect = new VMCView();
            this._elementEffect.auto = true;
            this._elementEffect.updatePose("90", true);
            this._elementEffect.move(_backImage.width / 2 + 1, _backImage.height / 2);
            addChild(this._elementEffect);
            addEvtListener(Event.ADDED_TO_STAGE, this.addToStage);
            addEvtListener(Event.REMOVED_FROM_STAGE, this.removeFromeStage);
            mouseChildren = false;
            return;
        }// end function

        public function setOpen(param1:Boolean) : void
        {
            if (param1)
            {
                _place = Params.ITEM_ELEMENT_HEART;
                this._accpetKey = [Params.ITEM_ELEMENT_HEART];
                if (this._openLock && this._openLock.parent)
                {
                    this._openLock.parent.removeChild(this._openLock);
                    this._openLock = null;
                }
            }
            else
            {
                _place = null;
                this._accpetKey = [];
                if (!this._openLock)
                {
                    this._openLock = ToolKit.getNewDO("elementHeart_playerLock") as Bitmap;
                    this._openLock.x = (_backImage.width - this._openLock.width) / 2;
                    this._openLock.y = (_backImage.height - this._openLock.height) / 2;
                    addChild(this._openLock);
                }
            }
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function get elementEffect() : VMCView
        {
            return this._elementEffect;
        }// end function

        public function get info() : ElementHeartInfo
        {
            return this._info;
        }// end function

        override public function setInfo(param1:Object, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1 is ElementHeartInfo)
            {
                this._info = param1 as ElementHeartInfo;
            }
            else
            {
                this._info = null;
            }
            if (this._info && this._info.lock)
            {
                if (!this._lockImage)
                {
                    this._lockImage = ToolKit.getNewDO("protectItemMark") as Bitmap;
                    addChild(this._lockImage);
                }
            }
            else if (this._lockImage)
            {
                if (this._lockImage.parent)
                {
                    this._lockImage.parent.removeChild(this._lockImage);
                }
                this._lockImage = null;
            }
            if (param1)
            {
                _loc_3 = "";
                _loc_4 = this._info.color;
                if (!this._info.isExpDan())
                {
                    _loc_3 = _loc_3 + ("<font color=\'#" + _loc_4 + "\'>" + this._info.q_name + "</font> Lv." + this._info.q_level + "<br/>");
                    _loc_3 = _loc_3 + (LanguageCfgObj.getInstance().getByIndex("eh1010", LANG) + " <font color=\'#" + _loc_4 + "\'>" + PropUtil.getElementColorText(this._info.q_quality) + "</font><br/>");
                    _loc_3 = _loc_3 + (LanguageCfgObj.getInstance().getByIndex("eh1015", LANG) + " " + this._info.exp + "/" + this._info.q_exp_max + "<br/>");
                    _loc_3 = _loc_3 + this._info.getAttrTips();
                }
                else
                {
                    _loc_3 = _loc_3 + ("<font color=\'#" + _loc_4 + "\'>" + this._info.q_name + "</font><br/>");
                    _loc_3 = _loc_3 + (LanguageCfgObj.getInstance().getByIndex("eh1010", LANG) + " <font color=\'#" + _loc_4 + "\'>" + PropUtil.getElementColorText(Math.abs(Math.abs(this._info.q_quality))) + "</font><br/>");
                    _loc_3 = _loc_3 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("eh1026", LANG), [this._info.q_swallow]);
                }
                this._elementEffect.loadRes((param1 as ElementHeartInfo).effectUrl, null, true);
                this._elementEffect.auto = true;
                if (this.type != ElementLocateType.ONPLAYER)
                {
                    this._elementEffect.smoothing = true;
                }
                ItemTips.create(this, param1, ElementHeartTips);
            }
            else
            {
                this._elementEffect.url = null;
                this._elementEffect.finalize();
                ItemTips.dispose(this);
            }
            if (this._isDrag && param1)
            {
                addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            }
            else
            {
                removeEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            }
            return;
        }// end function

        override protected function __click(event:MouseEvent) : void
        {
            if (!this.info)
            {
                event.stopImmediatePropagation();
                return;
            }
            if (_place == Params.ITEM_ELEMENT_HEART && this._info && this._info)
            {
                event.stopImmediatePropagation();
                return;
            }
            return;
        }// end function

        public function dragSucc(param1:Boolean, param2:Point = null) : void
        {
            this._elementEffect.alpha = 1;
            if (!param1 && this._info)
            {
                if (this._info.lock == 1)
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("eh1025", LANG));
                    return;
                }
                ElementHeartData.getInstance().dispatchEvt(new EHeartEvent(EHeartEvent.DRAG_FALSE, {p:param2, value:this}));
            }
            return;
        }// end function

        public function completeDrag(param1:Object, param2:IDragItem = null, param3:IDragItem = null) : void
        {
            var drag:ElementIconItem;
            var target:ElementIconItem;
            var swallow:ElementHeartInfo;
            var allExp:int;
            var nextLevel:ElementHeartInfo;
            var tips:String;
            var info:* = param1;
            var item:* = param2;
            var targetItem:* = param3;
            var MAX_LEVEL:* = ElementHeartData.MAX_LEVEL;
            if (item is ElementIconItem)
            {
                drag = item as ElementIconItem;
            }
            else
            {
                return;
            }
            if (targetItem is ElementIconItem)
            {
                target = targetItem as ElementIconItem;
            }
            else
            {
                return;
            }
            drag.elementEffect.alpha = 1;
            if (target.info == null)
            {
                if (target.type == ElementLocateType.ONPLAYER && drag.info.isExpDan())
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("eh1027", LANG));
                    return;
                }
                ElementHeartControl.getInstance().reqChangeIndex(drag.type, drag.index, target.type, target.index);
            }
            else if (drag.info.lock == 1)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("eh1016", LANG));
            }
            else if (target.info.isExpDan())
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("eh1028", LANG));
            }
            else
            {
                swallow = target.info;
                allExp = drag.info.exp + drag.info.q_swallow;
                nextLevel = QEHeartCfgObj.getInstance().getNextLevel(swallow.q_id, allExp + swallow.exp);
                if (swallow.q_level == 20 && swallow.exp == swallow.q_exp_max)
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("eh1019", LANG));
                    return;
                }
                tips = "<font color=\'#" + swallow.color + "\'>[" + swallow.q_name + "]</font>";
                if (!nextLevel)
                {
                    tips = LanguageCfgObj.getInstance().getByIndex("eh1019", LANG) + "<br/>" + tips;
                }
                if (!nextLevel && swallow.q_level != MAX_LEVEL)
                {
                    tips = tips + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("eh1022", LANG), [allExp, MAX_LEVEL]);
                }
                else if (nextLevel && nextLevel.q_level > swallow.q_level)
                {
                    tips = tips + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("eh1022", LANG), [allExp, nextLevel.q_level]);
                }
                else
                {
                    tips = tips + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("eh1021", LANG), [allExp]);
                }
                Global.popManager.cue(tips, null, null, function () : void
            {
                ElementHeartControl.getInstance().reqSwallow(drag.type, drag.index, target.type, target.index);
                return;
            }// end function
            );
            }
            return;
        }// end function

        protected function __mouseDown(event:MouseEvent) : void
        {
            addEvtListener(MouseEvent.MOUSE_MOVE, this.__doDrag);
            addEvtListener(MouseEvent.MOUSE_UP, this.__up);
            addEvtListener(MouseEvent.ROLL_OUT, this.__rollout);
            return;
        }// end function

        private function __rollout(event:MouseEvent) : void
        {
            removeEvtListener(MouseEvent.MOUSE_MOVE, this.__doDrag);
            removeEvtListener(MouseEvent.MOUSE_UP, this.__up);
            removeEvtListener(MouseEvent.ROLL_OUT, this.__rollout);
            return;
        }// end function

        protected function __up(event:MouseEvent) : void
        {
            removeEvtListener(MouseEvent.MOUSE_MOVE, this.__doDrag);
            removeEvtListener(MouseEvent.MOUSE_UP, this.__up);
            removeEvtListener(MouseEvent.ROLL_OUT, this.__rollout);
            return;
        }// end function

        protected function __doDrag(event:MouseEvent) : void
        {
            removeEvtListener(MouseEvent.MOUSE_MOVE, this.__doDrag);
            removeEvtListener(MouseEvent.ROLL_OUT, this.__rollout);
            DragManager.getInstance().doDrag(this, this._info, event.localX, event.localY, 40, 40);
            this._elementEffect.alpha = 0.3;
            return;
        }// end function

        public function dragAccept(param1:IDragItem, param2:Object = null) : Boolean
        {
            if (!visible)
            {
                return false;
            }
            return this.acceptKey().indexOf(param1.getKey()) != -1;
        }// end function

        public function dragEnter() : void
        {
            filters = this.filters.concat(FrameworkGlobal.ORANGE_FILTER);
            this._elementEffect.alpha = 0.3;
            return;
        }// end function

        public function dragOut() : void
        {
            filters = [];
            this._elementEffect.alpha = 1;
            return;
        }// end function

        public function getKey() : String
        {
            return _place;
        }// end function

        public function acceptKey() : Array
        {
            return this._accpetKey;
        }// end function

        private function addToStage(event:Event) : void
        {
            this._elementEffect.play();
            return;
        }// end function

        private function removeFromeStage(event:Event) : void
        {
            this._elementEffect.stop();
            return;
        }// end function

        override public function finalize() : void
        {
            this._elementEffect.finalize();
            removeEvtListener(Event.ADDED_TO_STAGE, this.addToStage);
            removeEvtListener(Event.REMOVED_FROM_STAGE, this.removeFromeStage);
            super.finalize();
            return;
        }// end function

    }
}
