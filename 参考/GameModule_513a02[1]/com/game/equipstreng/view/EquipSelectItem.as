package com.game.equipstreng.view
{
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class EquipSelectItem extends BaseButton implements IItem
    {
        private var img:DisplayObject;
        private var txt1:TextField;
        private var txt2:TextField;
        private var txt3:TextField;
        private var mc_equip:MovieClip;
        private var bg:MovieClip;
        private var _image:IconItem;
        private var _info:Object;

        public function EquipSelectItem(param1:String = "equipSelectItem")
        {
            super(param1);
            this.img = getDisplayChildByName("img");
            this.txt1 = getDisplayChildByName("txt1");
            this.txt1.selectable = false;
            this.txt2 = getDisplayChildByName("txt2");
            this.txt2.selectable = false;
            this.txt3 = getDisplayChildByName("txt3");
            this.txt3.selectable = false;
            this.mc_equip = getDisplayChildByName("mc_equip");
            this.bg = getDisplayChildByName("bg");
            this._image = new IconItem("");
            this._image.setWH(40, 40);
            this._image.setImageSize(40, 40);
            this._image.x = this.img.x;
            this._image.y = this.img.y;
            this.getDisplay().addChildAt(this._image, (getDisplay().getChildIndex(this.img) + 1));
            this.mc_equip.visible = false;
            return;
        }// end function

        override public function get key()
        {
            return _obj.label;
        }// end function

        public function set select(param1:Boolean) : void
        {
            if (param1)
            {
                this.bg.gotoAndStop(3);
            }
            else
            {
                this.bg.gotoAndStop(1);
            }
            this.selected = param1;
            return;
        }// end function

        public function get info()
        {
            return this._info;
        }// end function

        override public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            super.obj = param1;
            this.setInfo(param1);
            return;
        }// end function

        public function refresh() : void
        {
            this.setInfo(obj, true);
            return;
        }// end function

        private function setInfo(param1:Object, param2:Boolean = false) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            if (this._info != param1 || param2)
            {
                this._info = param1;
                if (this._info)
                {
                    addEvtListener(MouseEvent.MOUSE_OVER, this.__moveItem);
                    addEvtListener(MouseEvent.MOUSE_OUT, this.__outItem);
                    addEvtListener(MouseEvent.CLICK, this.__click);
                    addEvtListener("rightClick", this.__click);
                    addEvtListener(MouseEvent.DOUBLE_CLICK, this.__click);
                    if (this._info.url != this._image.image.url || param2)
                    {
                        this._image.setInfo(this._info);
                        _loc_3 = 0;
                        _loc_4 = PropUtil.getEquipColor(this._info);
                        _loc_5 = [PropUtil.getSuitName(this._info.suitId), PropUtil.getEquipName(this._info, false, true, false), PropUtil.getIntensify(this._info)];
                        _loc_6 = 0;
                        while (_loc_6 < _loc_5.length)
                        {
                            
                            _loc_8 = _loc_5[_loc_6];
                            if (_loc_8)
                            {
                                this["txt" + (_loc_3 + 1)].visible = true;
                                this["txt" + (_loc_3 + 1)].htmlText = _loc_8;
                                _loc_3++;
                            }
                            _loc_6++;
                        }
                        _loc_7 = _loc_3;
                        while (_loc_7 < 3)
                        {
                            
                            this["txt" + (_loc_7 + 1)].visible = false;
                            _loc_7++;
                        }
                        if (this._info.pos > 0)
                        {
                            this.mc_equip.visible = true;
                        }
                        else
                        {
                            this.mc_equip.visible = false;
                        }
                        var _loc_9:* = _loc_4;
                        this.txt3.textColor = _loc_4;
                        this.txt2.textColor = _loc_9;
                        this.txt1.textColor = _loc_9;
                    }
                    if (this._info is EquipmentInfo)
                    {
                        ItemTips.create(this, this._info, EquipTips);
                    }
                    else
                    {
                        ItemTips.create(this, this._info, PropTips);
                    }
                }
                else
                {
                    removeEvtListener(MouseEvent.CLICK, this.__click);
                    removeEvtListener("rightClick", this.__click);
                    removeEvtListener(MouseEvent.DOUBLE_CLICK, this.__click);
                    ItemTips.dispose(this);
                    this._image.finalize();
                }
            }
            return;
        }// end function

        private function __moveItem(event:MouseEvent) : void
        {
            if (this.bg && !selected)
            {
                this.bg.gotoAndStop(2);
            }
            return;
        }// end function

        private function __outItem(event:MouseEvent) : void
        {
            if (this.bg && !selected)
            {
                this.bg.gotoAndStop(1);
            }
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            return;
        }// end function

    }
}
