import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Contactus extends StatelessWidget {
  const Contactus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Html(
            data: """<article
class="post-40635 page type-page status-publish ast-article-single" id="post-40635" itemtype="https://schema.org/CreativeWork" itemscope="itemscope">
		<header class="entry-header ast-no-thumbnail ast-no-meta">
		
		<h1 class="entry-title" itemprop="headline">Contact US</h1>	</header><!-- .entry-header -->

	<div class="entry-content clear"
		itemprop="text"	>

		
		<p>Sahar Mangil, 1st Floor, Madrasa Mallick Para<br />
Chuadanga Sadar, Chuadnga -7200<br />
Phone: +880 1718 987202<br />
Email: hello@dokanpat.com<br />
Open Time: 24/7</p>

		
		
	</div><!-- .entry-content .clear -->

	
	
</article>""",
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).focusColor,
        onPressed: () {
          Get.back();
        },
        child: const FaIcon(FontAwesomeIcons.angleLeft),
      ),
    );
  }
}
