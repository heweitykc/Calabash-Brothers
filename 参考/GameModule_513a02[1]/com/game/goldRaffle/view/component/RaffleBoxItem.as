package com.game.goldRaffle.view.component
{
    import com.model.vo.*;
    import com.view.icon.*;

    public class RaffleBoxItem extends IconItem
    {

        public function RaffleBoxItem(param1:String = "goldRaffles_lotterBg")
        {
            super(param1);
            super.setWH(46, 46);
            _image.move(3, 3);
            return;
        }// end function

        override public function setWH(param1:uint, param2:uint) : void
        {
            super.setWH(param1, param2);
            if (param1 > 60)
            {
                _widthImg = 56;
                _heightImg = 56;
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
            super.setInfo(param1, true);
            return;
        }// end function

    }
}
