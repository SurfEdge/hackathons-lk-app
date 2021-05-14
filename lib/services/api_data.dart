class Data {
  final String title;
  final String eventLocation;
  final String eventStartDate;
  final String eventStartTime;
  final String eventEndDate;
  final String eventEndTime;
  final String status;
  final String website;
  final String image;
  final String views;
  final String content;
  final String contact;
  final String email;
  final String register;
  final String facebook;
  final String twitter;
  final String linkedin;

  Data(
      {this.title,
      this.eventLocation,
      this.eventStartDate,
      this.eventStartTime,
      this.eventEndDate,
      this.eventEndTime,
      this.status,
      this.website,
      this.image,
      this.views,
      this.content,
      this.contact,
      this.email,
      this.register,
      this.facebook,
      this.twitter,
      this.linkedin});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json['title']['rendered'].toString(),
      eventLocation: json['event_location'],
      eventStartDate: json['event_start_date'],
      eventStartTime: json['event_start_time'],
      eventEndDate: json['event_end_date'],
      eventEndTime: json['event_end_time'],
      status: (json['event_status'] == 'upcoming') ? 'Upcoming' : 'Ended',
      website: json['event_website'],
      image: (json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']
              .containsKey('medium_large'))
          ? json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']
              ['medium_large']['source_url']
          : json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']
              ['blog-default']['source_url'],
      views: json['post_views_count'],
      content: json['content']['rendered'],
      contact: json['event_phone'],
      email: json['event_email'],
      register: json['item_dribbble'],
      facebook: json['item_facebook'],
      twitter: json['item_twitter'],
      linkedin: json['item_linkedin'],
    );
  }
}
