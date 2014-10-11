package com.game.player.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.image.*;
    import com.f1.ui.tips.*;
    import com.f1.vmc.*;
    import com.game.backpack.control.*;
    import com.game.utils.*;
    import com.greensock.*;
    import com.manager.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import com.view.waterlight.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import interfaces.*;

    public class RoleEquipBox extends Component implements IDragItem
    {
        private var _pos:int;
        private var _image:Image;
        private var _info:EquipmentInfo;
        private var _place:String;
        private var _back:Sprite;
        private var _waterLight:WaterLight;
        private var _needEvent:Boolean;
        private var _mask:Sprite;
        private var _prefix:String;
        private var _suffix:String;
        private var _qualityEffect:VMCView;
        private var _accpetKey:Array;
        private var _dragTimeId:int;
        private var _priTimer:int;

        public function RoleEquipBox(param1 = null, param2:String = null, param3:Boolean = true)
        {
            super(param1, param2);
            display.visable = false;
            this._needEvent = param3;
            this._back = new Sprite();
            this._back.addChild(display.getChildAt(0));
            this._back.visible = false;
            addChild(this._back);
            this._prefix = "res/effect/role/";
            this._suffix = "/" + this._back.width + "x" + this._back.height + ".png";
            this._image = new Image();
            this._image.smoothing = true;
            addChild(this._image);
            this._mask = getDisplayChildByName("mc_mask");
            if (this._mask)
            {
                this._mask.visible = false;
                addChild(this._mask);
            }
            if (this._needEvent)
            {
                this.addListener();
            }
            this._place = Params.ITEM_PLACE_ROLEPANEL;
            this._qualityEffect = new VMCView();
            this._qualityEffect.auto = true;
            this._qualityEffect.updatePose("90", true);
            this._qualityEffect.move(this._back.width >> 1, this._back.height >> 1);
            addChild(this._qualityEffect);
            hitArea = this._back;
            addEvtListener(MouseEvent.ROLL_OVER, this.__over);
            addEvtListener(MouseEvent.ROLL_OUT, this.__out);
            return;
        }// end function

        public function get place() : String
        {
            return this._place;
        }// end function

        public function set place(param1:String) : void
        {
            this._place = param1;
            return;
        }// end function

        public function get info() : EquipmentInfo
        {
            return this._info;
        }// end function

        public function set info(param1:EquipmentInfo) : void
        {
            if (this._info != param1)
            {
                if (this.isInfoValid())
                {
                    this._info.removeEvtListener(Event.CHANGE, this.__infoChange);
                }
                this._info = param1;
                if (this.isInfoValid())
                {
                    this._info.addEvtListener(Event.CHANGE, this.__infoChange);
                }
                this.update();
            }
            if (!this.isInfoValid())
            {
                removeEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
                removeEvtListener("rightClick", this.__rightClick);
                removeEvtListener(MouseEvent.MOUSE_UP, this.__mouseUp);
            }
            return;
        }// end function

        private function update() : void
        {
            var _loc_1:* = null;
            this.cleanWater();
            this.setIcon();
            if (this.isInfoValid())
            {
                _loc_1 = "";
                if (this._info.q_remarkable)
                {
                    _loc_1 = _loc_1 + "remark";
                }
                if (this._info.intensify >= 13)
                {
                    _loc_1 = _loc_1 + "13";
                }
                else if (this._info.intensify >= 11)
                {
                    _loc_1 = _loc_1 + "11";
                }
                if (_loc_1 != "")
                {
                    _loc_1 = this._prefix + _loc_1 + this._suffix;
                    this._qualityEffect.loadRes(_loc_1, null, true);
                    this._qualityEffect.auto = true;
                    this._qualityEffect.move(this._back.width >> 1, this._back.height >> 1);
                }
                else
                {
                    this._qualityEffect.finalize();
                }
            }
            else
            {
                this._qualityEffect.finalize();
            }
            this.setTips();
            if (this._needEvent)
            {
                this.addListener();
            }
            return;
        }// end function

        private function __rightClick(event:MouseEvent) : void
        {
            if (this.isInfoValid())
            {
                BackPackControl.getInstance().takeOff(this._info.itemId);
            }
            return;
        }// end function

        private function setIcon() : void
        {
            if (this.isInfoValid() && this._info.q_item_icon)
            {
                this._image.load(Params.ROLE_EQUIP_PATH + this._info.q_item_icon + ".png", this.complete);
            }
            else
            {
                this._image.dispose();
                this.cleanWater();
            }
            return;
        }// end function

        private function cleanWater() : void
        {
            if (this._waterLight)
            {
                if (this._waterLight.parent)
                {
                    this._waterLight.parent.removeChild(this._waterLight);
                    this._waterLight.bitmapData = null;
                }
                this._waterLight.finalize();
                this._waterLight = null;
            }
            return;
        }// end function

        private function __mouseUp(event:MouseEvent) : void
        {
            clearTimeout(this._dragTimeId);
            return;
        }// end function

        private function complete(param1:BitmapData) : void
        {
            this._image.x = this._back.width - param1.width >> 1;
            this._image.y = this._back.height - param1.height >> 1;
            this.setWaterLight();
            return;
        }// end function

        public function setWaterLight() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            this.cleanWater();
            if (this._info.intensify >= 7)
            {
                _loc_1 = this._image.bitmapData;
                if (_loc_1)
                {
                    _loc_2 = this.getWaterLightColor(this._info.intensify, this._info.q_shine_color);
                    this._waterLight = new WaterLight(_loc_1, _loc_2);
                    this._waterLight.move(this._image.x, this._image.y);
                    this.addChild(this._waterLight);
                }
            }
            return;
        }// end function

        private function getWaterLightColor(param1:int, param2:String) : uint
        {
            var _loc_3:* = param2.split(";");
            if (_loc_3.length == 1)
            {
                return _loc_3[0];
            }
            if (param1 >= 9)
            {
                return uint(_loc_3[1]);
            }
            if (param1 >= 7)
            {
                return uint(_loc_3[0]);
            }
            return uint(_loc_3[0]);
        }// end function

        public function setWaterLightTest(param1:uint, param2:Number) : void
        {
            if (this._waterLight)
            {
                this._waterLight.color = param1;
                this._waterLight.alpha = param2;
            }
            return;
        }// end function

        private function setTips() : void
        {
            if (this.isInfoValid())
            {
                StringTip.dispose(this);
                ItemTips.create(this, this._info, EquipTips);
            }
            else
            {
                ItemTips.dispose(this);
                switch(this._pos)
                {
                    case Params.HEAD:
                    {
                        StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11012"));
                        break;
                    }
                    case Params.WING:
                    {
                        StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11013"));
                        break;
                    }
                    case Params.HAND:
                    {
                        StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11014"));
                        break;
                    }
                    case Params.RING1:
                    case Params.RING2:
                    {
                        StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11015"));
                        break;
                    }
                    case Params.BODY:
                    {
                        StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11016"));
                        break;
                    }
                    case Params.PET:
                    {
                        StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11017"));
                        break;
                    }
                    case Params.LEG:
                    {
                        StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11018"));
                        break;
                    }
                    case Params.SHOE:
                    {
                        StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11019"));
                        break;
                    }
                    case Params.NICKLACE:
                    {
                        StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11020"));
                        break;
                    }
                    case Params.LEFT_WEAPON:
                    {
                        StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11021"));
                        break;
                    }
                    case Params.RIGHT_WEAPON:
                    {
                        StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11021"));
                        break;
                    }
                    case Params.RIDE:
                    {
                        StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11019"));
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function dragEnter() : void
        {
            filters = this.filters.concat(FrameworkGlobal.ORANGE_FILTER);
            this._image.alpha = 0.3;
            return;
        }// end function

        public function dragOut() : void
        {
            filters = [];
            this._image.alpha = 1;
            return;
        }// end function

        public function completeDrag(param1:Object, param2:IDragItem = null, param3:IDragItem = null) : void
        {
            if (param2.getKey() == Params.ITEM_PLACE_BACKPACK)
            {
                if (!(param1 is EquipmentInfo))
                {
                    return;
                }
                BackPackControl.getInstance().equip(param1 as EquipmentInfo);
            }
            return;
        }// end function

        public function dragSucc(param1:Boolean, param2:Point = null) : void
        {
            if (param1)
            {
                this._image.dispose();
                BackPackControl.getInstance().takeOff(this.info.itemId);
            }
            this._image.alpha = 1;
            filters = [];
            return;
        }// end function

        public function getKey() : String
        {
            return this._place;
        }// end function

        public function acceptKey() : Array
        {
            return this._accpetKey;
        }// end function

        public function dragAccept(param1:IDragItem, param2:Object = null) : Boolean
        {
            if (!visible)
            {
                return false;
            }
            return this.getKey() != param1.getKey() && param2 is EquipmentInfo;
        }// end function

        private function addListener() : void
        {
            addEvtListener(MouseEvent.CLICK, this.__mouseClick);
            addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            addEvtListener("rightClick", this.__rightClick);
            addEvtListener(MouseEvent.MOUSE_UP, this.__mouseUp);
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            if (DragManager.getInstance().isInDrag())
            {
                DragManager.getInstance().onMouseIn(this);
            }
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            if (DragManager.getInstance().isInDrag())
            {
                DragManager.getInstance().onMouseOut(this);
            }
            return;
        }// end function

        private function __infoChange(event:Event) : void
        {
            this.update();
            return;
        }// end function

        private function __mouseDown(event:MouseEvent) : void
        {
            clearTimeout(this._dragTimeId);
            this._dragTimeId = setTimeout(this.doDrag, 200, mouseX, mouseY);
            return;
        }// end function

        private function doDrag() : void
        {
            DragManager.getInstance().doDrag(this, this._info, arguments[0], arguments[1], 40, 40);
            this._image.alpha = 0.3;
            return;
        }// end function

        private function __mouseClick(event:MouseEvent) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this._priTimer < 200)
            {
                this.doDoubleClick();
                this._priTimer = 0;
            }
            else
            {
                this._priTimer = _loc_2;
                TweenLite.delayedCall(0.2, this.singleClick, [mouseX, mouseY]);
            }
            return;
        }// end function

        private function singleClick(param1:int, param2:int) : void
        {
            this._priTimer = 0;
            if (this.isInfoValid())
            {
                BackPackControl.getInstance().itemPopUp(this._info, this, param1, param2);
            }
            return;
        }// end function

        private function isInfoValid() : Boolean
        {
            return !(this._info == null || long.isZero(this._info.itemId));
        }// end function

        private function doDoubleClick() : void
        {
            TweenLite.killDelayedCallsTo(this.singleClick);
            if (this.isInfoValid())
            {
                return;
            }
            BackPackControl.getInstance().takeOff(this._info.itemId);
            return;
        }// end function

        public function check(param1:PlayerInfo) : void
        {
            if (this._mask)
            {
                if (!this.isInfoValid())
                {
                    this._mask.visible = false;
                    return;
                }
                if (this._info.q_str_limit > param1.strength)
                {
                    this._mask.visible = true;
                    return;
                }
                if (this._info.q_vit_limit > param1.vitality)
                {
                    this._mask.visible = true;
                    return;
                }
                if (this._info.q_int_limit > param1.intelligence)
                {
                    this._mask.visible = true;
                    return;
                }
                if (this._info.q_agile_limit > param1.agile)
                {
                    this._mask.visible = true;
                    return;
                }
                this._mask.visible = false;
            }
            return;
        }// end function

        public function get pos() : int
        {
            return this._pos;
        }// end function

        public function set pos(param1:int) : void
        {
            this._pos = param1;
            this.setTips();
            return;
        }// end function

    }
}
