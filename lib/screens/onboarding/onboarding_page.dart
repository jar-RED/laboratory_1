import 'package:flutter/material.dart';
import '../home/home_page.dart';

class OnboardingPage extends StatelessWidget {
  final VoidCallback onFinish;
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const OnboardingPage({
    super.key,
    required this.onFinish,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: toggleTheme,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ],
      ),
      body: OnboardingPresenter(
        pages: [
          OnboardingModel(
            title: 'Capture & Upload',
            description: 'Take new photos or upload from your gallery.',
            imageUrl: 'assets/images/taking-photo.png',
          ),
          OnboardingModel(
            title: 'Organize Your Photos',
            description: 'Add titles and descriptions to your pictures.',
            imageUrl: 'assets/images/captioning.png',
          ),
          OnboardingModel(
            title: 'Showcase Your Memories',
            description: 'View and browse your saved photos anytime.',
            imageUrl: 'assets/images/viewing-photo.png',
          ),
        ],
        onFinish: () {
          onFinish();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HomePage(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
            ),
          );
        },
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class OnboardingModel {
  final String title;
  final String description;
  final String imageUrl;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class OnboardingPresenter extends StatefulWidget {
  final List<OnboardingModel> pages;
  final VoidCallback? onFinish;
  final bool isDarkMode;

  const OnboardingPresenter({
    super.key,
    required this.pages,
    this.onFinish,
    required this.isDarkMode,
  });

  @override
  State<OnboardingPresenter> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingPresenter> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDarkMode ? Colors.black : Colors.white;
    final textColor = widget.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.pages.length,
                onPageChanged: (idx) {
                  setState(() => _currentPage = idx);
                },
                itemBuilder: (context, idx) {
                  final item = widget.pages[idx];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: SizedBox(
                          width: 250,
                          height: 250,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              widget.isDarkMode ? Colors.white : Colors.black,
                              BlendMode.srcIn,
                            ),
                            child: Image.asset(item.imageUrl),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          item.title,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: textColor),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // Page indicator dots.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: _currentPage == index ? 30 : 8,
                  height: 8,
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            // Skip and Next/Finish buttons.
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: widget.onFinish,
                    child: Text("Skip", style: TextStyle(color: textColor)),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_currentPage == widget.pages.length - 1) {
                        widget.onFinish?.call();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          _currentPage == widget.pages.length - 1
                              ? "Finish"
                              : "Next",
                          style: TextStyle(color: textColor),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          _currentPage == widget.pages.length - 1
                              ? Icons.done
                              : Icons.arrow_forward,
                          color: textColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
