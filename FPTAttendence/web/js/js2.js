


      // Lấy context của canvas
      var ctx = document.getElementById('myChart').getContext('2d');
    
    // Tạo biểu đồ pie 
    var myChart = new Chart(ctx, {
      type: 'pie',
      data: {
        labels: ['Đi làm', 'Vắng'], 
        datasets: [{
          data: [35, 15],
          backgroundColor: [
            'rgba(75, 192, 192, 0.5)', 
            'rgba(255, 99, 132, 0.5)'
          ],
          borderColor: [
            'rgba(75, 192, 192, 1)', 
            'rgba(255,99,132, 1)'
          ]
        }]  
      },
      options: {
        responsive: true,
  maintainAspectRatio: false,
  width: ctx.canvas.width / 2, 
  height: ctx.canvas.height / 2
           
      }
    });
 
    function renderCalendar() {
        const calendarContainer = document.getElementById('calendar');
        const now = new Date();
        const currentMonth = now.getMonth();
        const currentYear = now.getFullYear();

        const monthNames = [
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        ];

        const dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

        // Header
        const header = document.createElement('div');
        header.classList.add('month-header');
        header.textContent = `${monthNames[currentMonth]} ${currentYear}`;
        calendarContainer.appendChild(header);

        // Day names
        const dayNamesContainer = document.createElement('div');
        dayNamesContainer.classList.add('days');
        dayNames.forEach(dayName => {
            const dayNameElement = document.createElement('div');
            dayNameElement.classList.add('day');
            dayNameElement.textContent = dayName;
            dayNamesContainer.appendChild(dayNameElement);
        });
        calendarContainer.appendChild(dayNamesContainer);

        // Days
        const daysContainer = document.createElement('div');
        daysContainer.classList.add('days');
        calendarContainer.appendChild(daysContainer);

        const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
        const firstDayOfMonth = new Date(currentYear, currentMonth, 1).getDay();

        for (let i = 0; i < firstDayOfMonth; i++) {
            const emptyDayElement = document.createElement('div');
            emptyDayElement.classList.add('day', 'empty');
            daysContainer.appendChild(emptyDayElement);
        }

        for (let day = 1; day <= daysInMonth; day++) {
            const dayElement = document.createElement('div');
            dayElement.classList.add('day');
            dayElement.textContent = day;

            if (day === now.getDate() && currentMonth === now.getMonth() && currentYear === now.getFullYear()) {
                dayElement.classList.add('current-month');
            }

            daysContainer.appendChild(dayElement);
        }
    }

    renderCalendar();
    

    


