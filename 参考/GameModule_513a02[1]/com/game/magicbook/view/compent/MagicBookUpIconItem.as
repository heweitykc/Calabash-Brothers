package com.game.magicbook.view.compent
{
    import com.view.icon.*;

    public class MagicBookUpIconItem extends IconItem
    {

        public function MagicBookUpIconItem()
        {
            super("PropBox66");
            setSize(64, 64);
            setWH(64, 64);
            _countTxt.y = 45;
            _countTxt.x = this.width - 8;
            setImageSize(56, 56);
            image.move(4, 4);
            return;
        }// end function

    }
}
