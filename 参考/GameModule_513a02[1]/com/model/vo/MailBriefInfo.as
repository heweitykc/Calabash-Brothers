package com.model.vo
{
    import com.game.mail.bean.*;

    public class MailBriefInfo extends MailSummaryInfo
    {
        private var _index:int;

        public function MailBriefInfo()
        {
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

    }
}
