import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:social_spot/models/ad.model.dart';

part 'api.service.g.dart';

@RestApi(baseUrl: "https://raptor-more-eft.ngrok-free.app")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/ad/random')
  Future<Ad> getRandomAd();

  @POST('/index.php')
  @FormUrlEncoded()
  Future<dynamic> login(
    @Query("zone") String zone,
    @Header("User-Agent") String userAgent,
    @Header("Referer") String referer,
    @Field("redirurl") String redirUrl,
    @Field("accept") String accept,
    @Field("checkbox") String checkbox,
  );
}
