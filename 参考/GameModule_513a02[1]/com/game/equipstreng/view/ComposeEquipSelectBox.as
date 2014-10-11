package com.game.equipstreng.view
{
    import __AS3__.vec.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.backpack.events.*;
    import com.game.backpack.model.*;
    import com.game.equipstreng.control.*;
    import com.game.equipstreng.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ComposeEquipSelectBox extends BaseBox
    {
        private var btn_page:Object;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn_close:BaseButton;
        private var img1:DisplayObject;
        private var img2:DisplayObject;
        private var img3:DisplayObject;
        private var img4:DisplayObject;
        private var img5:DisplayObject;
        private var img6:DisplayObject;
        private var img7:DisplayObject;
        private var img8:DisplayObject;
        private var img9:DisplayObject;
        private var img10:DisplayObject;
        private var txt:TextField;
        private var _cur_use_not_sign_item:String;
        private var _cur_use_not_sign_item_id:String;
        private var _cur_Q_Nonfinite_item:String;
        private var equipImage:EquipImage;
        private var equipImageFactory:Array;
        private var _vec:Vector.<EquipmentInfo>;
        private var totalPage:int = 0;
        private var curPage:int = 0;
        private var _type:int;
        private var _phase:int;

        public function ComposeEquipSelectBox(param1:String = "selectEquipBox")
        {
            this.equipImageFactory = [];
            super(param1);
            this.btn_page = getDisplayChildByName("btn_page");
            this.btn1 = new BaseButton(this.btn_page.getChildByName("btn_left"));
            this.btn2 = new BaseButton(this.btn_page.getChildByName("btn_right"));
            this.btn_close = new BaseButton(getDisplayChildByName("btn_close"));
            this.txt = this.btn_page.getChildByName("txt_page") as TextField;
            var _loc_2:* = 0;
            while (_loc_2 < 10)
            {
                
                this["img" + (_loc_2 + 1)] = getDisplayChildByName("img" + (_loc_2 + 1));
                _loc_2++;
            }
            var _loc_3:* = 0;
            while (_loc_3 < 10)
            {
                
                this.equipImage = new EquipImage();
                this["img" + (_loc_3 + 1)].addChild(this.equipImage);
                this.equipImageFactory.push(this.equipImage);
                _loc_3++;
            }
            if (this.btn_close)
            {
                this.btn_close.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.btn1.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn2.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            BackpackObj.getInstance().addEvtListener(BackpackEvent.BOX_REMOVE, this.refresh);
            return;
        }// end function

        public function get phase() : int
        {
            return this._phase;
        }// end function

        public function set phase(param1:int) : void
        {
            this._phase = param1;
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            switch(event.target)
            {
                case this.btn1:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.curPage - 1;
                    _loc_2.curPage = _loc_3;
                    if (this.curPage < 1)
                    {
                        this.curPage = 1;
                    }
                    this.showImage();
                    break;
                }
                case this.btn2:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.curPage + 1;
                    _loc_2.curPage = _loc_3;
                    if (this.curPage > this.totalPage)
                    {
                        this.curPage = this.totalPage;
                    }
                    this.showImage();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function showImage() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < 10)
            {
                
                if (this.equipImageFactory[_loc_1])
                {
                    this.equipImageFactory[_loc_1].setInfo(null);
                    this.equipImageFactory[_loc_1].removeEventListener(MouseEvent.CLICK, this.clickHandler);
                }
                _loc_1++;
            }
            if (this.vec)
            {
                _loc_2 = this.vec.slice((this.curPage - 1) * 10, this.curPage * 10);
                _loc_1 = 0;
                while (_loc_1 < _loc_2.length && _loc_1 < 10)
                {
                    
                    if (this.equipImageFactory[_loc_1])
                    {
                        this.equipImageFactory[_loc_1].setInfo(_loc_2[_loc_1], false, "", 40, 40);
                        this.equipImageFactory[_loc_1].addEventListener(MouseEvent.CLICK, this.clickHandler);
                    }
                    _loc_1++;
                }
            }
            this.txt.text = this.curPage + "/" + this.totalPage;
            return;
        }// end function

        private function clickHandler(event:MouseEvent) : void
        {
            if (event.currentTarget.info)
            {
                EquipComposeControl.getInstance().equipComposeBox.showSelectEquip(event.currentTarget.info);
                this.refresh(null);
                close();
            }
            return;
        }// end function

        override public function open() : void
        {
            this.curPage = 1;
            super.open();
            this.refresh(null);
            return;
        }// end function

        private function filterEquip() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (!this.cur_use_not_sign_item && this._type == 0)
            {
                return;
            }
            if (!this._cur_Q_Nonfinite_item && this._type == 1)
            {
                return;
            }
            if (this._type == EquipForgeData.TYPE_ANGEL && !this.cur_use_not_sign_item_id)
            {
                return;
            }
            if (this._type == 1)
            {
                _loc_1 = this._cur_Q_Nonfinite_item.split(",");
                this.vec = EquipForgeData.getInstance().filterComposeEquipBagAddRate(_loc_1, EquipForgeData.saveEquipIdAdd);
            }
            else if (this._type == 0)
            {
                _loc_1 = this.cur_use_not_sign_item.split(",");
                this.vec = EquipForgeData.getInstance().filterComposeEquipBag(_loc_1, this.cur_use_not_sign_item_id, EquipForgeData.saveEquipIdAdd);
            }
            else if (this._type == EquipForgeData.TYPE_ANGEL)
            {
                _loc_1 = this.cur_use_not_sign_item_id.split("_");
                if (this._phase > -1 && this._phase < _loc_1.length)
                {
                    _loc_2 = _loc_1[this._phase];
                    this.vec = EquipForgeData.getInstance().filterComposeAngelEquip(_loc_2, EquipForgeData.saveEquipIdAdd);
                }
            }
            this.totalPage = Math.ceil(this.vec.length / 10);
            if (this.totalPage < 1)
            {
                this.totalPage = 1;
            }
            this.txt.text = this.curPage + "/" + this.totalPage;
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

        private function refresh(event:BackpackEvent) : void
        {
            if (this.parent)
            {
                this.filterEquip();
                this.showImage();
            }
            return;
        }// end function

        public function set cur_use_not_sign_item(param1:String) : void
        {
            this._cur_use_not_sign_item = param1;
            this.filterEquip();
            this.showImage();
            return;
        }// end function

        public function get cur_use_not_sign_item() : String
        {
            return this._cur_use_not_sign_item;
        }// end function

        public function get cur_use_not_sign_item_id() : String
        {
            return this._cur_use_not_sign_item_id;
        }// end function

        public function set cur_use_not_sign_item_id(param1:String) : void
        {
            this._cur_use_not_sign_item_id = param1;
            return;
        }// end function

        public function get vec() : Vector.<EquipmentInfo>
        {
            return this._vec;
        }// end function

        public function set vec(param1:Vector.<EquipmentInfo>) : void
        {
            this._vec = param1;
            return;
        }// end function

        public function get cur_Q_Nonfinite_item() : String
        {
            return this._cur_Q_Nonfinite_item;
        }// end function

        public function set cur_Q_Nonfinite_item(param1:String) : void
        {
            this._cur_Q_Nonfinite_item = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

    }
}
