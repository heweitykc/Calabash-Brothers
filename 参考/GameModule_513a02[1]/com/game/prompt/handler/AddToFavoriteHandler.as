package com.game.prompt.handler
{
    import com.game.prompt.message.*;
    import net.*;

    public class AddToFavoriteHandler extends Handler
    {

        public function AddToFavoriteHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = AddToFavoriteMessage(this.message);
            return;
        }// end function

    }
}
