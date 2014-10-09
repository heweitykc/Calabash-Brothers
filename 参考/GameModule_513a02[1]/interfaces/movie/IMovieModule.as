package interfaces.movie
{
    import com.f1.interfaces.*;

    public interface IMovieModule extends IModule
    {

        public function IMovieModule();

        function getNewMovie(param1:String) : IMovie;

    }
}
