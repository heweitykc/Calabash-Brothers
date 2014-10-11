package com.game.guide.control
{
    import com.game.guide.view.*;

    public class WelcomePageControl extends Object
    {
        public const RES_URL:String = "res/welcomepage.swf";
        private var welcomeView:WelcomePageView;
        private static var _instance:WelcomePageControl;

        public function WelcomePageControl()
        {
            return;
        }// end function

        public function showWelcome() : void
        {
            if (!this.welcomeView)
            {
                this.welcomeView = new WelcomePageView();
            }
            this.welcomeView.open();
            return;
        }// end function

        public static function getInstance() : WelcomePageControl
        {
            var _loc_1:* = new WelcomePageControl;
            _instance = new WelcomePageControl;
            return _instance || _loc_1;
        }// end function

    }
}
