package com.game.gradegift.view.component
{
    import com.model.vo.*;
    import com.view.icon.*;

    public class GiftIconItem extends IconItem
    {

        public function GiftIconItem(param1:String = "shopboxbg")
        {
            super(param1);
            super.setWH(46, 46);
            buttonMode = true;
            mouseChildren = false;
            _image.move(3, 3);
            _countTxt.x = this.width - 10;
            _countTxt.y = this.height - 20;
            return;
        }// end function

        override public function setWH(param1:uint, param2:uint) : void
        {
            super.setWH(param1, param2);
            if (param1 > 60)
            {
                _widthImg = 50;
                _heightImg = 50;
            }
            _image.setSize(param1, param2);
            setImageXY((param1 - _widthImg) / 2, (param2 - _widthImg) / 2);
            return;
        }// end function

        public function set info(param1:PropInfo) : void
        {
            _info = param1;
            this.setInfo(_info);
            return;
        }// end function

        override public function setInfo(param1:Object, param2:Boolean = false) : void
        {
            super.setInfo(param1, param2);
            return;
        }// end function

        public function setNum(param1:int) : void
        {
            _countTxt.text = param1.toString();
            return;
        }// end function

    }
}
